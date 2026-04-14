import 'package:firebase_database/firebase_database.dart';
import '../models/narapidana.dart';

class NarapidanaService {
  final DatabaseReference _narapidanaRef =
      FirebaseDatabase.instance.ref('narapidana');

  Stream<List<Narapidana>> getNarapidanaStream() {
    return _narapidanaRef.onValue.map((event) {
      final data = event.snapshot.value;

      if (data == null) {
        return <Narapidana>[];
      }

      final Map<dynamic, dynamic> rawMap = data as Map<dynamic, dynamic>;
      final List<Narapidana> items = rawMap.entries.map((entry) {
        return Narapidana.fromMap(
          entry.key.toString(),
          entry.value as Map<dynamic, dynamic>,
        );
      }).toList();

      items.sort((a, b) => a.nama.toLowerCase().compareTo(b.nama.toLowerCase()));
      return items;
    });
  }

  Future<void> tambahNarapidana({
    required String nama,
    required String jenisKelamin,
    required int umur,
    required String kasus,
  }) async {
    final DatabaseReference newRef = _narapidanaRef.push();
    await newRef.set({
      'nama': nama,
      'jenisKelamin': jenisKelamin,
      'umur': umur,
      'kasus': kasus,
    });
  }
}
