# 🔥 Firebase Setup for Flutter (Auth + Firestore)

Dokumentasi ini menjelaskan cara setup Firebase pada project Flutter dari awal hingga siap digunakan, termasuk:

* Firebase Core
* Firebase Authentication
* Cloud Firestore

---

## 📌 Prasyarat

Pastikan sudah terinstall:

* Flutter SDK
* Node.js (untuk install Firebase CLI)
* Akun Firebase

---

## 🚀 1. Install Firebase CLI (via NPM)

```bash
npm install -g firebase-tools
```

Login ke Firebase:

```bash
firebase login
```

---

## ⚙️ 2. Install FlutterFire CLI

```bash
dart pub global activate flutterfire_cli
```

---

## 🔥 3. Hubungkan Firebase ke Project Flutter

Jalankan di root project Flutter:

```bash
flutterfire configure
```

Langkah ini akan:

* Menghubungkan project ke Firebase
* Membuat file konfigurasi:

```
lib/firebase_options.dart
```

---

## 📦 4. Install Dependency Flutter

Tambahkan ke `pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter

  firebase_core: ^3.15.2
  firebase_auth: ^5.3.3
  cloud_firestore: ^5.6.12
```

Kemudian jalankan:

```bash
flutter pub get
```

---

## 🔌 5. Inisialisasi Firebase

Edit file `main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}
```

---

## 🔐 6. Setup Authentication

1. Buka Firebase Console
2. Pilih project
3. Masuk ke **Authentication → Sign-in Method**
4. Aktifkan:

   * Email/Password

---

## 🗄️ 7. Setup Firestore Database

1. Masuk ke **Firestore Database**
2. Klik **Create Database**
3. Pilih **Start in Test Mode**
4. Pilih region

---

## 💻 8. Contoh Penggunaan

### ✅ Register User

```dart
import 'package:firebase_auth/firebase_auth.dart';

Future<void> register(String email, String password) async {
  await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );
}
```

---

### ✅ Login User

```dart
Future<void> login(String email, String password) async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: email,
    password: password,
  );
}
```

---

### ✅ Tambah Data ke Firestore

```dart
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUser() async {
  await FirebaseFirestore.instance.collection('users').add({
    'name': 'Kensa',
    'age': 20,
  });
}
```

---

### ✅ Ambil Data dari Firestore

```dart
Future<void> getUsers() async {
  var data = await FirebaseFirestore.instance.collection('users').get();

  for (var doc in data.docs) {
    print(doc.data());
  }
}
```

---

## ⚠️ Troubleshooting

### ❌ Firebase belum diinisialisasi

**Error:**

```
Firebase has not been initialized
```

**Solusi:**
Pastikan:

```dart
await Firebase.initializeApp();
```

---

### ❌ File konfigurasi tidak ditemukan

Pastikan sudah menjalankan:

```bash
flutterfire configure
```

---

### ❌ Permission Firestore ditolak

Gunakan rule sementara (untuk testing):

```js
allow read, write: if true;
```

> ⚠️ Jangan gunakan di production

---

### ❌ Error setelah setup

Coba jalankan:

```bash
flutter clean
flutter pub get
```

---
# Catatan Penting
Flutter tidak menggunakan NPM untuk dependency
NPM hanya digunakan untuk install Firebase CLI
Gunakan FlutterFire CLI untuk konfigurasi otomatis


# Aplikasi Pendataan Narapidana - Flutter + Firebase Realtime Database

Project ini dibuat untuk memenuhi kisi-kisi UTS praktek dengan ketentuan:
- Menampilkan data narapidana di halaman utama
- Menambahkan data narapidana
- Menyimpan data ke Firebase Realtime Database
- Menampilkan data secara real-time

## Fitur Aplikasi

- Halaman utama menampilkan list data narapidana
- Form tambah data narapidana
- Validasi input form
- Penyimpanan data ke Firebase Realtime Database
- Update data secara real-time menggunakan `StreamBuilder`

## Data yang Disimpan

Setiap data narapidana memiliki field:
- Nama
- Jenis Kelamin
- Umur
- Kasus

## Teknologi yang Digunakan

- Flutter
- Firebase Core
- Firebase Realtime Database

## Struktur Folder

```bash
lib/
├── main.dart
├── firebase_options.dart
├── models/
│   └── narapidana.dart
├── services/
│   └── narapidana_service.dart
└── screens/
    ├── home_screen.dart
    └── tambah_narapidana_screen.dart
```

## Langkah 1 - Membuat Project Firebase

1. Buka Firebase Console.
2. Klik **Create Project**.
3. Buat project dengan nama:
   - `latihanuts`
4. Klik **Continue** sampai project selesai dibuat.
5. Masuk ke menu **Realtime Database**.
6. Klik **Create Database**.
7. Pilih region.
8. Pilih **Test Mode** agar saat latihan/ujian lebih mudah digunakan.
9. Klik **Enable**.

### Contoh Rules Saat Test

Gunakan rules berikut agar aplikasi bisa membaca dan menulis data tanpa login:

```json
{
  "rules": {
    ".read": true,
    ".write": true
  }
}
```

> Catatan: Rules ini cocok untuk demo, latihan, dan ujian. Untuk project asli, sebaiknya gunakan autentikasi dan rules yang lebih aman.

## Langkah 2 - Membuat Project Flutter

Jalankan perintah berikut:

```bash
flutter create latihanuts_flutter
cd latihanuts_flutter
```

## Langkah 3 - Menambahkan Dependency

Tambahkan package berikut:

```bash
flutter pub add firebase_core
flutter pub add firebase_database
```

Atau isi `pubspec.yaml` seperti berikut:

```yaml
dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.8
  firebase_core: ^4.6.0
  firebase_database: ^12.3.0
```

## Langkah 4 - Hubungkan Flutter dengan Firebase

Install FlutterFire CLI bila belum ada:

```bash
dart pub global activate flutterfire_cli
```

Lalu jalankan:

```bash
flutterfire configure
```

### Saat menjalankan `flutterfire configure`

- Pilih project Firebase: `latihanuts`
- Pilih platform yang digunakan, minimal:
  - Android
- Setelah selesai, file `lib/firebase_options.dart` akan dibuat otomatis.

## Langkah 5 - Isi Source Code

Ganti isi file sesuai struktur berikut.

---

## 1. `lib/main.dart`

```dart
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'screens/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Latihan UTS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
```

---

## 2. `lib/models/narapidana.dart`

```dart
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
```

---

## 3. `lib/services/narapidana_service.dart`

```dart
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
```

---

## 4. `lib/screens/home_screen.dart`

```dart
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
```

---

## 5. `lib/screens/tambah_narapidana_screen.dart`

```dart
import 'package:flutter/material.dart';
import '../services/narapidana_service.dart';

class TambahNarapidanaScreen extends StatefulWidget {
  const TambahNarapidanaScreen({super.key});

  @override
  State<TambahNarapidanaScreen> createState() => _TambahNarapidanaScreenState();
}

class _TambahNarapidanaScreenState extends State<TambahNarapidanaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _namaController = TextEditingController();
  final _umurController = TextEditingController();
  final _kasusController = TextEditingController();
  final NarapidanaService _service = NarapidanaService();

  String? _jenisKelamin;
  bool _isLoading = false;

  @override
  void dispose() {
    _namaController.dispose();
    _umurController.dispose();
    _kasusController.dispose();
    super.dispose();
  }

  Future<void> _simpanData() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _service.tambahNarapidana(
        nama: _namaController.text.trim(),
        jenisKelamin: _jenisKelamin!,
        umur: int.parse(_umurController.text.trim()),
        kasus: _kasusController.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data narapidana berhasil disimpan')),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan data: $e')),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Narapidana'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _jenisKelamin,
                decoration: const InputDecoration(
                  labelText: 'Jenis Kelamin',
                  border: OutlineInputBorder(),
                ),
                items: const [
                  DropdownMenuItem(value: 'Laki-laki', child: Text('Laki-laki')),
                  DropdownMenuItem(value: 'Perempuan', child: Text('Perempuan')),
                ],
                onChanged: (value) {
                  setState(() {
                    _jenisKelamin = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Jenis kelamin wajib dipilih';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _umurController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Umur',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Umur wajib diisi';
                  }
                  final umur = int.tryParse(value.trim());
                  if (umur == null || umur <= 0) {
                    return 'Umur harus berupa angka lebih dari 0';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _kasusController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Kasus',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kasus wajib diisi';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _simpanData,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Simpan Data'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

## Langkah 6 - Jalankan Aplikasi

```bash
flutter pub get
flutter run
```

## Struktur Data di Firebase Realtime Database

Data akan tersimpan seperti ini:

```json
{
  "narapidana": {
    "-OP001": {
      "nama": "Budi",
      "jenisKelamin": "Laki-laki",
      "umur": 30,
      "kasus": "Pencurian"
    },
    "-OP002": {
      "nama": "Siti",
      "jenisKelamin": "Perempuan",
      "umur": 28,
      "kasus": "Penipuan"
    }
  }
}
```

## Penjelasan Alur Program

### 1. Inisialisasi Firebase
Pada `main.dart`, aplikasi memanggil:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

Fungsinya untuk menghubungkan aplikasi Flutter dengan project Firebase.

### 2. Membaca Data Real-time
Pada `narapidana_service.dart`, data diambil dari path:

```dart
FirebaseDatabase.instance.ref('narapidana')
```

Kemudian dibaca dengan:

```dart
_narapidanaRef.onValue
```

Karena menggunakan `onValue`, maka setiap ada perubahan data di Firebase, aplikasi akan langsung update otomatis.

### 3. Menambah Data
Saat tombol **Simpan Data** ditekan, aplikasi memanggil:

```dart
final DatabaseReference newRef = _narapidanaRef.push();
await newRef.set({...});
```

`push()` digunakan untuk membuat ID unik otomatis.

### 4. Menampilkan Data
Di `home_screen.dart`, data ditampilkan menggunakan:

```dart
StreamBuilder<List<Narapidana>>
```

Sehingga list akan berubah otomatis jika data di Firebase berubah.

## Komponen Penting yang Bisa Dijelaskan Saat Ujian

### Kenapa memakai Firebase Realtime Database?
Karena data bisa langsung sinkron secara real-time tanpa perlu refresh manual.

### Kenapa memakai `StreamBuilder`?
Karena `StreamBuilder` cocok untuk menampilkan data stream yang terus berubah.

### Kenapa memakai folder `model`, `service`, dan `screen`?
Agar kode lebih rapi:
- `model` untuk bentuk data
- `service` untuk akses Firebase
- `screen` untuk tampilan UI

## Kendala yang Sering Terjadi

### 1. Error `firebase_options.dart` tidak ada
Solusi:
- Jalankan `flutterfire configure`

### 2. Data tidak bisa disimpan
Solusi:
- Pastikan Realtime Database sudah aktif
- Pastikan rules database mengizinkan read dan write
- Pastikan project Firebase yang dipilih benar

### 3. `Firebase.initializeApp()` error
Solusi:
- Pastikan `firebase_core` sudah terpasang
- Pastikan file `firebase_options.dart` sudah dibuat otomatis
- Pastikan `WidgetsFlutterBinding.ensureInitialized()` dipanggil sebelum inisialisasi Firebase

## Kesimpulan

Aplikasi ini sudah memenuhi seluruh kebutuhan soal:
- Ada halaman utama
- Bisa menambah data narapidana
- Data yang disimpan: nama, jenis kelamin, umur, kasus
- Data tersimpan di Firebase Realtime Database
- Data tampil kembali secara real-time

## Catatan Penting untuk Repository GitHub

Saat upload ke GitHub, pastikan file berikut ikut ada:
- `lib/main.dart`
- `lib/models/narapidana.dart`
- `lib/services/narapidana_service.dart`
- `lib/screens/home_screen.dart`
- `lib/screens/tambah_narapidana_screen.dart`
- `pubspec.yaml`
- `README.md`

File `firebase_options.dart` boleh ikut di-repository jika sudah digenerate. Kalau belum, tulis di README bahwa file tersebut dibuat menggunakan:

```bash
flutterfire configure
```

## Saran Tambahan Kalau Ingin Nilai Lebih Bagus

Kalau dosen memperbolehkan pengembangan tambahan, kamu bisa menambahkan:
- fitur edit data
- fitur hapus data
- pencarian data
- validasi umur yang lebih detail
- tampilan UI yang lebih menarik

---

## Perintah Cepat Saat Ujian

```bash
flutter create latihanuts_flutter
cd latihanuts_flutter
flutter pub add firebase_core
flutter pub add firebase_database
dart pub global activate flutterfire_cli
flutterfire configure
flutter pub get
flutter run
```

---

Semoga lancar saat UTS.
