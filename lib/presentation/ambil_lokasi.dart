import 'dart:convert';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class JadwalSholatService {
  // 1. Fungsi untuk Mendapatkan Nama Lokasi (seperti sebelumnya)
  Future<String> getLocationName() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) return "GPS Tidak Aktif";

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) return "Izin Ditolak";
      }
      if (permission == LocationPermission.deniedForever)
        return "Izin Ditolak Permanen";

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 8),
      );

      final url = Uri.parse(
        'https://nominatim.openstreetmap.org/reverse?format=json&lat=${position.latitude}&lon=${position.longitude}&zoom=12&addressdetails=1',
      );

      final response = await http
          .get(url, headers: {'User-Agent': 'bitaqwa_app'})
          .timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final address = data['address'];
        if (address != null) {
          String city =
              address['city'] ??
              address['town'] ??
              address['village'] ??
              address['state'] ??
              'Lokasi Ditemukan';
          return city;
        }
      }
      return "Lokasi Ditemukan";
    } catch (e) {
      return "Gagal memuat lokasi";
    }
  }

  // 2. FUNGSI BARU: Mengambil Jadwal Sholat Berdasarkan Koordinat GPS
  Future<Map<String, String>?> fetchPrayerTimes() async {
    try {
      // Dapatkan koordinat saat ini terlebih dahulu
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 8),
      );

      // Endpoint Aladhan API (Metode 2 biasanya Kementerian Agama RI / MWL)
      // Format tanggal otomatis menggunakan hari ini
      final url = Uri.parse(
        'https://api.aladhan.com/v1/timings?latitude=${position.latitude}&longitude=${position.longitude}&method=2',
      );

      final response = await http.get(url).timeout(const Duration(seconds: 6));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final timings = data['data']['timings'];

        // Mengambil jam sholat utama (Subuh, Dzuhur, Ashar, Maghrib, Isya)
        return {
          "Subuh": timings['Fajr'] ?? "04:30",
          "Dzuhur": timings['Dhuhr'] ?? "11:45",
          "Ashar": timings['Asr'] ?? "15:00",
          "Maghrib": timings['Maghrib'] ?? "17:45",
          "Isya": timings['Isha'] ?? "19:00",
        };
      }
      return null;
    } catch (e) {
      return null; // Jika gagal, nanti bisa di-fallback ke jadwal default
    }
  }
}
