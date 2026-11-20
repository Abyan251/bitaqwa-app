import 'package:flutter/material.dart';
import 'package:bitaqwa/presentation/header_widget.dart';
import 'package:bitaqwa/presentation/ambil_lokasi.dart'; // File service yang berisi JadwalSholatService

class SholatScreen extends StatefulWidget {
  const SholatScreen({super.key});

  @override
  State<SholatScreen> createState() => _SholatScreenState();
}

class _SholatScreenState extends State<SholatScreen> {
  // State untuk menyimpan lokasi & status loading
  String _lokasiInfo = "Mendeteksi lokasi...";
  bool _isLoadingLocation = true;

  // Data jadwal sholat default (sebelum API merespons)
  Map<String, String> _jadwalSholatData = {
    "Subuh": "--:--",
    "Dzuhur": "--:--",
    "Ashar": "--:--",
    "Maghrib": "--:--",
    "Isya": "--:--",
  };

  @override
  void initState() {
    super.initState();
    _loadDataLengkap(); // Ambil lokasi dan jadwal sekaligus saat halaman dibuka
  }

  // Fungsi untuk mengambil Nama Lokasi & Jadwal Sholat dari API
  Future<void> _loadDataLengkap() async {
    setState(() {
      _isLoadingLocation = true;
      _lokasiInfo = "Mendeteksi lokasi...";
    });

    final service = JadwalSholatService();

    // 1. Ambil nama lokasi (Kota/Kabupaten)
    String hasilLokasi = await service.getLocationName();

    // 2. Ambil jadwal sholat berdasarkan koordinat GPS
    Map<String, String>? hasilJadwal = await service.fetchPrayerTimes();

    setState(() {
      _lokasiInfo = hasilLokasi;
      if (hasilJadwal != null) {
        _jadwalSholatData = hasilJadwal; // Update waktu sholat sesuai tempat
      }
      _isLoadingLocation = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List daftar sholat yang dihubungkan dengan data dari API
    final List<Map<String, dynamic>> jadwalSholatList = [
      {
        "nama": "Subuh",
        "waktu": _jadwalSholatData["Subuh"],
        "icon": Icons.nightlight_round,
      },
      {
        "nama": "Dzuhur",
        "waktu": _jadwalSholatData["Dzuhur"],
        "icon": Icons.wb_sunny,
      },
      {
        "nama": "Ashar",
        "waktu": _jadwalSholatData["Ashar"],
        "icon": Icons.wb_twilight,
      },
      {
        "nama": "Maghrib",
        "waktu": _jadwalSholatData["Maghrib"],
        "icon": Icons.nightlight,
      },
      {
        "nama": "Isya",
        "waktu": _jadwalSholatData["Isya"],
        "icon": Icons.dark_mode,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FB),

      // APP BAR
      appBar: AppBar(
        title: const Text(
          "Jadwal Sholat",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),

      // BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER & INFORMASI LOKASI
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                headerUngu(
                  title: 'Jadwal Sholat',
                  icon: Icons.access_time,
                  description:
                      'Temukan jadwal sholat untuk lokasi kamu dengan mudah.',
                ),

                const SizedBox(height: 12),

                // Baris Info Lokasi dan Tombol Refresh
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(
                            Icons.location_on,
                            color: Color(0xFF645477),
                            size: 20,
                          ),
                          const SizedBox(width: 6),
                          Expanded(
                            child: Text(
                              _isLoadingLocation
                                  ? "Mendeteksi lokasi..."
                                  : "Lokasi: $_lokasiInfo",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF645477),
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Tombol Refresh Lokasi & Jadwal
                    IconButton(
                      icon: _isLoadingLocation
                          ? const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.refresh, color: Color(0xFF645477)),
                      onPressed: _isLoadingLocation ? null : _loadDataLengkap,
                      tooltip: "Cari Ulang Lokasi & Jadwal",
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 25),

            // LIST JADWAL SHOLAT (Dinamis Berdasarkan Tempat/API)
            ListView.builder(
              itemCount: jadwalSholatList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final sholat = jadwalSholatList[index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    children: [
                      // ICON
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFF645477).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Icon(
                          sholat["icon"] as IconData?,
                          color: const Color(0xFF645477),
                        ),
                      ),

                      const SizedBox(width: 15),

                      // NAMA SHOLAT
                      Expanded(
                        child: Text(
                          sholat["nama"] as String,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // WAKTU (Otomatis berubah mengikuti tempat/API)
                      _isLoadingLocation
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Text(
                              sholat["waktu"] as String,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF645477),
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 15),

            // CATATAN
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.info_outline, color: Color(0xFFF29470)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Jadwal sholat di atas disesuaikan secara otomatis "
                      "berdasarkan lokasi koordinat tempat Anda saat ini.",
                      style: TextStyle(height: 1.5, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
