abstract class MqttEvent {}

// Dipanggil saat pertama kali aplikasi dibuka di main.dart untuk koneksi awal
class MqttConnectRequested extends MqttEvent {}

// Dipanggil otomatis oleh Stream slotStream saat ada angka slot baru dari ESP2
class MqttSlotUpdated extends MqttEvent {
  final int newSlot;
  MqttSlotUpdated(this.newSlot);
}

// Dipanggil otomatis oleh Stream uidStream saat ada KTP menempel di ESP1 (Gerbang Masuk)
class MqttUidScanned extends MqttEvent {
  final String uid;
  MqttUidScanned(this.uid);
}

// [BARU]: Dipanggil otomatis oleh Stream uidKeluarStream saat ada KTP menempel di ESP2 (Gerbang Keluar)
class MqttUidKeluarScanned extends MqttEvent {
  final String uid;
  MqttUidKeluarScanned(this.uid);
}