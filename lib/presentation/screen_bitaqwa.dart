import 'package:flutter/material.dart';
import 'package:bitaqwa/presentation/header_widget.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    // =========================
    // HEADER
    // =========================

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              header(),
              // =========================
              // MENU UTAMA
              // =========================
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 20,
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 10,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 133, 85),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _menuItem(
                      context: context,
                      icon: Icons.front_hand,
                      label: "Doa-doa",
                      route: 'doa',
                    ),
                    _menuItem(
                      context: context,
                      icon: Icons.calculate,
                      label: "Zakat",
                      route: 'zakat',
                    ),
                    _menuItem(
                      context: context,
                      icon: Icons.mosque,
                      label: "Jadwal Sholat",
                      route: 'sholat',
                    ),
                    _menuItem(
                      context: context,
                      icon: Icons.nightlight_round,
                      label: "Video Kajian",
                      route: 'kajian',
                    ),
                  ],
                ),
              ),

              // =========================
              // INSPIRASI
              // =========================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 22, vertical: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Inspirasi",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              // Kartu inspirasi
              _inspirationCard(
                title: "Tahajud",
                description:
                    "Dan pada sebagian malam hari bertahajudlah kamu sebagai suatu ibadah tambahan bagimu.",
                icon: Icons.nightlight_round,
              ),

              _inspirationCard(
                title: "Berbuat Baik",
                description:
                    "Kebaikan yang kita lakukan dapat menjadi jalan untuk mendekatkan diri kepada Allah.",
                icon: Icons.favorite,
              ),

              _inspirationCard(
                title: "Bersyukur",
                description:
                    "Bersyukur atas nikmat yang diberikan Allah membuat hati menjadi lebih tenang.",
                icon: Icons.auto_awesome,
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  // =========================
  // MENU ITEM
  // =========================
  static Widget _menuItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String route,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route),
        child: Column(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF645477),
              ),
              child: Icon(icon, size: 38, color: Colors.white),
            ),

            const SizedBox(height: 8),

            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =========================
  // INSPIRATION CARD
  // =========================
  static Widget _inspirationCard({
    required String title,
    required String description,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
      width: double.infinity,
      height: 220,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF405476), Color(0xFF1F304D)],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          // Dekorasi bintang
          const Positioned(
            top: 20,
            left: 25,
            child: Icon(Icons.star, color: Color(0xFFFFE477), size: 18),
          ),

          const Positioned(
            top: 55,
            right: 30,
            child: Icon(Icons.star, color: Colors.white, size: 15),
          ),

          // Isi
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: const Color(0xFFFFE477), size: 40),

                  const SizedBox(height: 8),

                  Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
