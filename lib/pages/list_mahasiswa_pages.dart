import 'package:flutter/material.dart';
import 'tambah_mahasiswa.dart';

class ListMahasiswaPages extends StatefulWidget {
  const ListMahasiswaPages({super.key});

  @override
  State<ListMahasiswaPages> createState() => _ListMahasiswaPagesState();
}

class _ListMahasiswaPagesState extends State<ListMahasiswaPages> {
  // Data awal yang diwajibkan dari dokumen UTS
  final List<Map<String, String>> students = [
    {
      'name': 'Budi Santoso',
      'avatar': 'https://i.pravatar.cc/150?img=1',
      'domisili': 'Jakarta Selatan',
      'phone': '081234567890'
    },
    {
      'name': 'Sari Dewi',
      'avatar': 'https://i.pravatar.cc/150?img=5',
      'domisili': 'Bekasi',
      'phone': '087654321098'
    },
    {
      'name': 'Ahmad Fauzi',
      'avatar': 'https://i.pravatar.cc/150?img=3',
      'domisili': 'Depok',
      'phone': '082198765432'
    },
    {
      'name': 'Rina Kusuma',
      'avatar': 'https://i.pravatar.cc/150?img=8',
      'domisili': 'Tangerang Selatan',
      'phone': '089876543210'
    },
    {
      'name': 'Dian Pratama',
      'avatar': 'https://i.pravatar.cc/150?img=11',
      'domisili': 'Bogor',
      'phone': '085678901234'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        elevation: 0,
        title: const Text(
          'Student Directory',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 22,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: Colors.grey.shade100,
            height: 1.0,
          ),
        ),
      ),
      // PERBAIKAN: Menggunakan ListView untuk tampilan list row sesuai permintaan
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: students.length,
        itemBuilder: (context, index) {
          final student = students[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade200),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  // TODO: Navigasi ke Halaman 3 (Profile) bawa data student
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey.shade100,
                        // Menampilkan foto avatar dari URL
                        backgroundImage: NetworkImage(student['avatar']!),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              student['name']!,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              student['domisili']!,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TambahMahasiswaPage()),
          );
        },
        backgroundColor: Colors.black,
        shape: const CircleBorder(),
        elevation: 3,
        child: const Icon(
          Icons.add,
          color: Colors.white,
          size: 28,
        ),
      ),
    );
  }
}