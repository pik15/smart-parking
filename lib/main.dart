import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_parking_app1/data/models/parkir_log.dart';
import 'package:smart_parking_app1/data/models/user_ktp.dart';
import 'package:smart_parking_app1/data/services/mqtt_service.dart';
import 'package:smart_parking_app1/logic/bloc/mqtt_bloc.dart';
import 'package:smart_parking_app1/logic/bloc/mqtt_event.dart';
import 'package:smart_parking_app1/logic/cubit/history_cubit.dart';
import 'package:smart_parking_app1/presentation/router/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open(
    [ParkirLogSchema, UserKtpSchema],
    directory: dir.path,
  );

  final MqttService mqttService = MqttService();

  runApp(
    RepositoryProvider<MqttService>.value(
      value: mqttService,
      child: MultiBlocProvider(
        providers: [
          // 1. Inisialisasi HistoryCubit terlebih dahulu agar bisa dipakai oleh MqttBloc
          BlocProvider<HistoryCubit>(
            create: (context) => HistoryCubit(isar: isar),
          ),
          // 2. Inisialisasi MqttBloc dengan menyuntikkan HistoryCubit ke dalamnya
          BlocProvider<MqttBloc>(
            create: (context) => MqttBloc(
              mqttService: mqttService,
              isar: isar,
              historyCubit: context.read<HistoryCubit>(), // <--- Disuntikkan ke sini secara aman!
            )..add(MqttConnectRequested()),
          ),
        ],
        child: MyApp(mqttService: mqttService, isar: isar),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final MqttService mqttService;
  final Isar isar;

  const MyApp({Key? key, required this.mqttService, required this.isar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Keren! BlocListener dilepas karena pencatatan log sudah ditangani otomatis 
    // oleh MqttBloc langsung di latar belakang saat validasi RFID sukses.
    return MaterialApp.router(
      title: 'Smart Parking App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
      ),
      routerConfig: AppRouter.router,
    );
  }
}