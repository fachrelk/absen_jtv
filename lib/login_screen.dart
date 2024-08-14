import 'package:absen_jtv/home_screen.dart';
import 'package:flutter/material.dart';
import 'main.dart'; // Import MyHomePage untuk navigasi setelah login

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isCheckedIn = false; // Untuk melacak status check-in

  void _loginAndCheckIn() async {
    // Simulasi proses login
    if (_emailController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
      // Simulasi check-in
      setState(() {
        _isCheckedIn = true;
      });

      // Pindah ke halaman utama setelah login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(title: 'Absen Cuy'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _loginAndCheckIn,
              child: const Text('Login and Check-in'),
            ),
          ],
        ),
      ),
    );
  }
}
