import 'package:bitaqwa/data/dummy/doa_data.dart';
import 'package:bitaqwa/enum/kategori_doa_enum.dart';
import 'package:bitaqwa/presentation/detail_doa_screen.dart';
import 'package:bitaqwa/presentation/get_asset.dart';
import 'package:flutter/material.dart';
import 'package:bitaqwa/presentation/header_widget.dart';

class DoaListScreen extends StatelessWidget {
  final DoaCategory category;

  const DoaListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final doaList = doaData[category] ?? [];
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Doa list'),
      ),

      body: ListView.builder(
        itemCount: doaList.length,
        itemBuilder: (context, index) {
          final doa = doaList[index];
          headerImages(image: getAssetPath());

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 16.0,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[200]!,
                    blurRadius: 3.0,
                    spreadRadius: 1.0,
                  ),
                ],
              ),
              child: ListTile(
                leading: Image.asset(doa.image),
                title: Text(
                  doa.title,
                  style: const TextStyle(fontFamily: 'Poppinsmedium'),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailDoaScreen(
                        title: doa.title,
                        arabicText: doa.arabicText,
                        reference: doa.reference,
                        translation: doa.translation,
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
