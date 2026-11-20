import 'package:bitaqwa/data/dummy/kategori_doa_data.dart';
import 'package:bitaqwa/data/dummy/kategori_doa_ext.dart';
import 'package:bitaqwa/presentation/card_doa.dart';
import 'package:bitaqwa/presentation/doa_list_screen.dart';
import 'package:bitaqwa/presentation/header_widget.dart';
import 'package:flutter/material.dart';

class DoaScreen extends StatelessWidget {
  const DoaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Doa - Doa",
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
            headerUngu(
              title: 'Doa Harian',
              icon: Icons.auto_stories,
              description:
                  'Temukan doa harian yang kamu butuhkan dengan mudah.',
            ),

            const SizedBox(height: 25),

            const Text(
              "Kategori Doa",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            SizedBox(
              height: 400,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: GridView.builder(
                  itemCount: doaCategoryData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemBuilder: (context, index) {
                    final item = doaCategoryData[index];

                    const SizedBox(height: 25);

                    return CardDoa(
                      image: item.category.image,
                      title: item.category.title,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                DoaListScreen(category: item.category),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
