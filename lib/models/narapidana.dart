class Narapidana {
  final String id;
  final String nama;
  final String jenisKelamin;
  final int umur;
  final String kasus;

  Narapidana({
    required this.id,
    required this.nama,
    required this.jenisKelamin,
    required this.umur,
    required this.kasus,
  });

  Map<String, dynamic> toMap() {
    return {
      'nama': nama,
      'jenisKelamin': jenisKelamin,
      'umur': umur,
      'kasus': kasus,
    };
  }

  factory Narapidana.fromMap(String id, Map<dynamic, dynamic> map) {
    return Narapidana(
      id: id,
      nama: map['nama']?.toString() ?? '',
      jenisKelamin: map['jenisKelamin']?.toString() ?? '',
      umur: int.tryParse(map['umur'].toString()) ?? 0,
      kasus: map['kasus']?.toString() ?? '',
    );
  }
}
