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
            const Spacer(),
            Image.asset(
              'assets/logo_jtv.png',
              width: 40,
              height: 40,
            ),
          ],
        ),
        backgroundColor: Colors.teal.shade600,
        elevation: 8,
        shadowColor: Colors.teal.shade900,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal.shade300, Colors.teal.shade700],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                // Row untuk menampilkan "Halo", gambar tangan, dan "Fachrel"
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.teal.shade50,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const Text(
                        'Halo',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Image.asset(
                        'assets/tangan.png',
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 10),
                      const Text(
                        'Fachrel',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Semangat magang nya!',
                  style: TextStyle(
                    fontSize: 22,
                    fontStyle: FontStyle.italic,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          _currentTime,
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                          ),
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
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 8,
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
                              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              elevation: 8,
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
                          labelStyle: TextStyle(color: Colors.teal),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                          color: Colors.teal,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Riwayat Aksi:',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                ..._history.map((entry) => ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  tileColor: Colors.white.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  title: Text(
                    entry,
                    style: const TextStyle(color: Colors.teal,
                  ),
                )),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
