import 'dart:async';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _currentTime;
  late String _lastActionTime;
  late Timer _timer;

  List<String> _history = []; // Menyimpan riwayat masuk dan keluar
  final TextEditingController _noteController = TextEditingController(); // Controller untuk catatan
  String _note = ''; // Catatan yang ditambahkan

  @override
  void initState() {
    super.initState();
    _currentTime = _getCurrentTime();
    _lastActionTime = ''; // Awal tidak ada waktu aksi
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer t) => _updateTime());
  }

  @override
  void dispose() {
    _timer.cancel();
    _noteController.dispose();
    super.dispose();
  }

  String _getCurrentTime() {
    // Mendapatkan waktu saat ini dengan format jam dan menit
    DateTime now = DateTime.now();
    return "${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}";
  }

  void _updateTime() {
    setState(() {
      _currentTime = _getCurrentTime();
    });
  }

  void _onMasukPressed() {
    setState(() {
      _lastActionTime = "Masuk berhasil pada $_currentTime";
      _history.add("Masuk pada $_currentTime: $_note"); // Menambahkan riwayat
      _note = ''; // Reset catatan setelah aksi
      _noteController.clear(); // Hapus isi TextField
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_lastActionTime)),
    );
  }

  void _onKeluarPressed() {
    setState(() {
      _lastActionTime = "Keluar berhasil pada $_currentTime";
      _history.add("Keluar pada $_currentTime: $_note"); // Menambahkan riwayat
      _note = ''; // Reset catatan setelah aksi
      _noteController.clear(); // Hapus isi TextField
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(_lastActionTime)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Absen Cuy'),
            const Spacer(), // Spacer memisahkan teks dan logo
            Image.asset(
              'assets/logo_jtv.png', // Pastikan path ini benar
              width: 40,
              height: 40,
            ),
          ],
        ),
        backgroundColor: Colors.teal.shade600,
        elevation: 8,
        shadowColor: Colors.teal.shade900,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal.shade200, Colors.teal.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: <Widget>[
            // Membuat tampilan Halo dan Fachrel dengan gambar tangan di tengah
            Center(
              child: Column(
                children: [
                  const Text(
                    'Halo',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'Fachrel',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    'assets/tangan.png',
                    width: 150,
                    height: 150,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            // Container untuk jam dan tombol
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // perubahan posisi bayangan
                  ),
                ],
              ),
              child: Column(
                children: <Widget>[
                  // Menampilkan waktu saat ini di tengah
                  Text(
                    _currentTime,
                    style: const TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _onMasukPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Masuk',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _onKeluarPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 5,
                        ),
                        child: const Text(
                          'Keluar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _noteController,
                    decoration: const InputDecoration(
                      labelText: 'Ngapain aja kamu hari ini',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    ),
                    maxLines: 2,
                    onChanged: (text) {
                      setState(() {
                        _note = text;
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    _lastActionTime.isEmpty ? '' : _lastActionTime,
                    style: const TextStyle(
                      fontSize: 18,
                      fontStyle: FontStyle.italic,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Riwayat aksi, jika ada
            if (_history.isNotEmpty) ...[
              const Text(
                'Riwayat Aksi:',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              ..._history.map((entry) => ListTile(
                contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
                title: Text(entry),
              )),
            ],
          ],
        ),
      ),
    );
  }
}
