abstract class MqttState {}

class MqttInitial extends MqttState {}

class MqttLoading extends MqttState {}

// Pusat data aktif aplikasi. UI tinggal memanggil state.sisaSlot atau state.scannetUid
class MqttConnected extends MqttState {
  final int sisaSlot;
  final String scannetUid; // Menampung UID KTP ter-scan untuk auto-fill di form registrasi
  MqttConnected({required this.sisaSlot, this.scannetUid = ''});
}

class MqttDisconnected extends MqttState {}