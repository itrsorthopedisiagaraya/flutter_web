import 'package:flutter/material.dart';
import 'screen/admin/dashboard/dashboard.dart';
import 'screen/auth/login.dart';
import 'screen/auth/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jadwal Dokter',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.blue,
        brightness: Brightness.light,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/regis': (context) => const RegisterPage(),
        '/dashboard': (context) => const AdminDashboardPage(),
      },
    );
  }
}
