import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bitaqwa/presentation/header_widget.dart';

class ZakatScreen extends StatefulWidget {
  const ZakatScreen({super.key});

  @override
  State<ZakatScreen> createState() => _ZakatScreenState();
}

class _ZakatScreenState extends State<ZakatScreen> {
  final TextEditingController hartaController = TextEditingController();

  // Format Rupiah Indonesia
  final NumberFormat formatRupiah = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp ',
    decimalDigits: 0,
  );

  double harta = 0;

  // null = belum diverifikasi
  // true = sudah haul
  // false = belum haul
  bool? sudahHaul;

  // Harga emas contoh, bukan data real-time.
  static const double hargaEmasPerGram = 1500000;

  // Nisab setara 85 gram emas.
  double get nisab => 85 * hargaEmasPerGram;

  // Cek apakah harta mencapai nisab.
  bool get mencapaiNisab => harta >= nisab && harta > 0;

  // Hitung zakat jika nisab dan haul terpenuhi.
  double get hasilZakat {
    if (mencapaiNisab && sudahHaul == true) {
      return harta * 0.025;
    }

    return 0;
  }

  // Mengubah teks menjadi nominal angka.
  double parseNominal(String value) {
    final angka = value.replaceAll(RegExp(r'[^0-9]'), '');
    return double.tryParse(angka) ?? 0;
  }

  // Format input Rupiah dan perbarui harta.
  void onHartaChanged(String value) {
    final nominal = parseNominal(value);

    final teksFormat = nominal == 0
        ? ''
        : NumberFormat.decimalPattern('id_ID').format(nominal.toInt());

    if (hartaController.text != teksFormat) {
      hartaController.value = TextEditingValue(
        text: teksFormat,
        selection: TextSelection.collapsed(offset: teksFormat.length),
      );
    }

    setState(() {
      harta = nominal;
    });
  }

  // Tombol hitung zakat.
  void hitungZakat() {
    setState(() {
      harta = parseNominal(hartaController.text);
    });

    FocusScope.of(context).unfocus();
  }

  // Menghapus input dan verifikasi.
  void reset() {
    setState(() {
      hartaController.clear();
      harta = 0;
      sudahHaul = null;
    });
  }

  @override
  void dispose() {
    hartaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FB),

      appBar: AppBar(
        title: const Text(
          'Zakat',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            headerUngu(
              title: 'Zakat',
              icon: Icons.volunteer_activism,
              description: 'Hitung simulasi zakat mal kamu dengan mudah.',
            ),

            const SizedBox(height: 25),

            // INPUT HARTA
            const Text(
              'Jumlah Harta',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            TextField(
              controller: hartaController,
              keyboardType: TextInputType.number,
              onChanged: onHartaChanged,
              decoration: InputDecoration(
                hintText: 'Masukkan jumlah harta',
                prefixText: 'Rp ',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(18),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // VERIFIKASI HAUL
            const Text(
              'Verifikasi Haul',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 8),

            const Text(
              'Apakah harta ini sudah dimiliki selama '
              'satu tahun Hijriah?',
              style: TextStyle(height: 1.5),
            ),

            const SizedBox(height: 8),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  RadioListTile<bool>(
                    title: const Text('Ya, sudah satu tahun Hijriah'),
                    value: true,
                    // ignore: deprecated_member_use
                    groupValue: sudahHaul,
                    // ignore: deprecated_member_use
                    onChanged: (value) {
                      setState(() {
                        sudahHaul = value;
                      });
                    },
                  ),

                  RadioListTile<bool>(
                    title: const Text('Belum satu tahun Hijriah'),
                    value: false,
                    // ignore: deprecated_member_use
                    groupValue: sudahHaul,
                    // ignore: deprecated_member_use
                    onChanged: (value) {
                      setState(() {
                        sudahHaul = value;
                      });
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            const SizedBox(height: 10),

            // HASIL PERHITUNGAN
            const Text(
              'Hasil Perhitungan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),

              child: Column(
                children: [
                  const Text(
                    'Estimasi Zakat Mal',
                    style: TextStyle(color: Colors.black54, fontSize: 16),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    formatRupiah.format(hasilZakat),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF645477),
                    ),
                  ),

                  const SizedBox(height: 10),

                  const Text(
                    'Persentase zakat: 2,5%',
                    style: TextStyle(color: Colors.black45),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    harta <= 0
                        ? 'Masukkan jumlah harta terlebih dahulu.'
                        : !mencapaiNisab
                        ? 'Harta belum mencapai nisab.'
                        : sudahHaul == null
                        ? 'Verifikasi haul untuk melanjutkan.'
                        : sudahHaul == true
                        ? 'Nisab dan haul terpenuhi '
                              'berdasarkan input.'
                        : 'Haul belum terpenuhi.',
                    textAlign: TextAlign.center,
                    style: const TextStyle(height: 1.5),
                  ),

                  const Divider(height: 30),

                  // INFORMASI NISAB
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Nisab (85 gram emas): '
                      '${formatRupiah.format(nisab)}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // STATUS NISAB
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: harta <= 0
                          ? const Color(0xFFF3F0F5)
                          : mencapaiNisab
                          ? const Color(0xFFE6F5E9)
                          : const Color(0xFFFFF1E9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          harta <= 0
                              ? Icons.info_outline
                              : mencapaiNisab
                              ? Icons.check_circle_outline
                              : Icons.info_outline,
                          color: harta <= 0
                              ? Colors.grey
                              : mencapaiNisab
                              ? Colors.green
                              : const Color(0xFFF29470),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            harta <= 0
                                ? 'Masukkan jumlah harta terlebih dahulu.'
                                : mencapaiNisab
                                ? 'Harta mencapai nisab berdasarkan '
                                      'harga emas contoh.'
                                : 'Harta belum mencapai nisab '
                                      'berdasarkan harga emas contoh.',
                            style: const TextStyle(height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 12),

                  // STATUS HAUL
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: sudahHaul == null
                          ? const Color(0xFFF3F0F5)
                          : sudahHaul!
                          ? const Color(0xFFE6F5E9)
                          : const Color(0xFFFFF1E9),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          sudahHaul == null
                              ? Icons.help_outline
                              : sudahHaul!
                              ? Icons.check_circle_outline
                              : Icons.info_outline,
                          color: sudahHaul == null
                              ? Colors.grey
                              : sudahHaul!
                              ? Colors.green
                              : const Color(0xFFF29470),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            sudahHaul == null
                                ? 'Haul belum diverifikasi.'
                                : sudahHaul!
                                ? 'Haul terpenuhi berdasarkan '
                                      'jawabanmu.'
                                : 'Haul belum terpenuhi '
                                      'berdasarkan jawabanmu.',
                            style: const TextStyle(height: 1.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // INFORMASI ZAKAT
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF1E9),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Color(0xFFF29470)),

                  SizedBox(width: 12),

                  Expanded(
                    child: Text(
                      'Perhitungan ini merupakan simulasi zakat mal. '
                      'Harga emas yang digunakan masih berupa contoh, '
                      'bukan data pasar real-time. Kewajiban zakat '
                      'juga bergantung pada jenis harta, nisab, haul, '
                      'dan ketentuan zakat yang berlaku.',
                      style: TextStyle(height: 1.5),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
