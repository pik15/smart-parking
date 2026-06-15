import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_parking_app1/presentation/screens/dashboard_screen.dart';
import 'package:smart_parking_app1/presentation/screens/history_screen.dart';
import 'package:smart_parking_app1/presentation/screens/ktp_registration_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const MainNavigationShell(),
      ),
    ],
  );
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const HistoryScreen(),
    const KtpRegistrationScreen(),
  ];

  // Konstanta warna utama dari tema baru (Pink/Maroon)
  static const Color primaryThemeColor = Color(0xFFFE6694);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        selectedItemColor: primaryThemeColor,
        // [FIXED]: Memperbaiki penulisan kode warna hex 8-digit yang valid untuk item yang tidak dipilih
        unselectedItemColor: const Color(0xFF8A94A6), 
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
        unselectedLabelStyle: const TextStyle(fontSize: 12),
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            activeIcon: Icon(Icons.grid_view_rounded),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.access_time_rounded),
            activeIcon: Icon(Icons.access_time_filled_rounded),
            label: 'Riwayat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.badge_outlined),
            activeIcon: Icon(Icons.badge),
            label: 'Registrasi E-KTP',
          ),
        ],
      ),
    );
  }
}