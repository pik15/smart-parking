import 'dart:async';
import 'dart:developer'
    as developer; // [SOLUSI]: Untuk menggantikan print() sesuai standar linter
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  late MqttServerClient client;
  final _slotController = StreamController<int>.broadcast();
  final _uidMasukController = StreamController<String>.broadcast();
  final _uidKeluarController = StreamController<String>.broadcast();

  Stream<int> get slotStream => _slotController.stream;
  Stream<String> get uidMasukStream => _uidMasukController.stream;
  Stream<String> get uidKeluarStream => _uidKeluarController.stream;

  StreamSubscription<List<MqttReceivedMessage<MqttMessage?>>>?
      _updatesSubscription;

  Future<void> setupMqtt() async {
    String clientId = 'flutter_client_${DateTime.now().millisecondsSinceEpoch}';

    client = MqttServerClient('test.mosquitto.org', clientId);
    client.port = 1883;
    client.keepAlivePeriod = 20;
    client.logging(on: false);

    client.autoReconnect = true;

    client.onDisconnected = () {
      developer.log(
          'Koneksi terputus dari Mosquitto. Mencoba menghubungkan ulang otomatis...');
    };

    client.onAutoReconnected = () {
      developer.log(
          'Aplikasi berhasil terhubung kembali secara otomatis ke Mosquitto!');
      _subscribeToTopics();
    };

    final connMessage = MqttConnectMessage()
        .withClientIdentifier(clientId)
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMessage;

    try {
      developer.log('Menghubungkan ke Mosquitto Broker...');
      await client.connect();
    } catch (e) {
      developer.log('Gagal terhubung ke Mosquitto: $e');
      client.disconnect();
    }

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      developer.log('Aplikasi Sukses Terhubung ke Broker Mosquitto!');
      _subscribeToTopics();
    }
  }

  void _subscribeToTopics() {
    developer.log('Melakukan subscribe ke topik-topik smart parking...');
    client.subscribe('opik/parking/status_slot', MqttQos.atMostOnce);
    client.subscribe('opik/parking/uid_scan', MqttQos.atMostOnce);
    client.subscribe('opik/parking/uid_keluar', MqttQos.atMostOnce);

    _updatesSubscription?.cancel();

    _updatesSubscription =
        client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final MqttPublishMessage recMess = c![0].payload as MqttPublishMessage;
      final String pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      final String topic = c[0].topic;

      if (topic == 'opik/parking/status_slot') {
        int? slot = int.tryParse(pt);
        if (slot != null) _slotController.add(slot);
      } else if (topic == 'opik/parking/uid_scan') {
        _uidMasukController.add(pt);
      } else if (topic == 'opik/parking/uid_keluar') {
        _uidKeluarController.add(pt); //  BENAR
      }
    });
  }

  void publishMessage(String topic, String message) {
    try {
      if (client.connectionStatus?.state == MqttConnectionState.connected) {
        final builder = MqttClientPayloadBuilder();
        builder.addString(message);
        client.publishMessage(topic, MqttQos.atMostOnce, builder.payload!);
        developer.log('Berhasil publish ke $topic: $message');
      } else {
        developer.log(
            'Gagal Publish: Aplikasi sedang tidak terhubung ke broker Mosquitto.');
      }
    } catch (e) {
      developer.log('Eror saat publish message: $e');
    }
  }

  void dispose() {
    _updatesSubscription?.cancel();
    _slotController.close();
    _uidMasukController.close();
    _uidKeluarController.close();
  }
}
