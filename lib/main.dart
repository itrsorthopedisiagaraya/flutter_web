import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screen/admin/admin_layout.dart';
import 'screen/admin/admin_state.dart';
import 'screen/auth/login.dart';
import 'screen/auth/register.dart';

void main() {
  runApp(
    ChangeNotifierProvider(create: (_) => AdminState(), child: const MyApp()),
  );
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
        '/admin': (context) => const AdminLayout(),
      },
    );
  }
}
