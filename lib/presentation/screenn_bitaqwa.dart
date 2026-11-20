import 'package:flutter/material.dart';

class DoaScreen extends StatefulWidget {
  const DoaScreen({super.key});

  @override
  State<DoaScreen> createState() => _DoaScreenState();
}

class _DoaScreenState extends State<DoaScreen> {
  final List<String> doa = [
    "Doa Sebelum Tidur",
    "Doa Bangun Tidur",
    "Doa Masuk Rumah",
    "Doa Keluar Rumah",
    "Doa Sebelum Makan",
    "Doa Sesudah Makan",
    "Doa Untuk Kedua Orang Tua",
    "Doa Naik Kendaraan",
  ];

  String pencarian = "";

  @override
  Widget build(BuildContext context) {
    List<String> hasil = doa
        .where((item) => item.toLowerCase().contains(pencarian.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Doa-doa")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: "Cari doa...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  pencarian = value;
                });
              },
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: hasil.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: const CircleAvatar(child: Icon(Icons.menu_book)),
                      title: Text(hasil[index]),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        // Nanti kita isi detail doa
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
