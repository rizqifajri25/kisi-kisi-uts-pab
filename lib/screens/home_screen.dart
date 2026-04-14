import 'package:flutter/material.dart';
import '../models/narapidana.dart';
import '../services/narapidana_service.dart';
import 'tambah_narapidana_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final NarapidanaService _service = NarapidanaService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Narapidana'),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Narapidana>>(
        stream: _service.getNarapidanaStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Terjadi kesalahan: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          final data = snapshot.data ?? [];

          if (data.isEmpty) {
            return const Center(
              child: Text(
                'Belum ada data narapidana.\nSilakan tambahkan data baru.',
                textAlign: TextAlign.center,
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return Card(
                elevation: 3,
                margin: const EdgeInsets.only(bottom: 12),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.nama,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Jenis Kelamin: ${item.jenisKelamin}'),
                      Text('Umur: ${item.umur} tahun'),
                      const SizedBox(height: 6),
                      Text('Kasus: ${item.kasus}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TambahNarapidanaScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
