import 'package:flutter/material.dart';
import 'package:bitaqwa/presentation/get_asset.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

Widget header() {
  return Container(
    height: 360,
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(getAssetPath()),
        fit: BoxFit.fill,
      ),
    ),
    child: Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Assalamualaikum Fulan',
            style: TextStyle(
              fontFamily: 'Arial',
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget headerImages({required String image}) {
  return Container(
    height: 250,
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
    ),
    child: Center(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Assalamualaikum Fulan',
            style: TextStyle(
              fontFamily: 'PoppinsMedium',
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}

Widget headerUngu({
  required String title,
  required IconData icon,
  required String description,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(25),

    decoration: BoxDecoration(
      color: const Color(0xFF645477),
      borderRadius: BorderRadius.circular(25),
    ),

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Icon(icon, color: Colors.white, size: 50),

        const SizedBox(height: 15),

        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          description,
          style: TextStyle(
            color: Colors.white.withValues(alpha: 0.85),
            fontSize: 15,
          ),
        ),
      ],
    ),
  );
}

Widget headerShalatberikutnya(String namaSholat, String waktuSholat) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
      color: const Color(0xFFFFF1E9),
      borderRadius: BorderRadius.circular(20),
    ),

    child: Row(
      children: [
        Container(
          width: 55,
          height: 55,

          decoration: const BoxDecoration(
            color: Color(0xFFF29470),
            shape: BoxShape.circle,
          ),

          child: const Icon(Icons.access_time, color: Colors.white),
        ),

        const SizedBox(width: 15),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text(
                "Sholat Berikutnya",
                style: TextStyle(color: Colors.black54),
              ),

              SizedBox(height: 3),

              Text(
                namaSholat,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),

        Text(
          waktuSholat,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF645477),
          ),
        ),
      ],
    ),
  );
}
