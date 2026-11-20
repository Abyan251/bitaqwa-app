import 'package:flutter/material.dart';
import 'package:bitaqwa/presentation/header_widget.dart';
import 'package:bitaqwa/data/dummy/kajian_data.dart';
import 'package:bitaqwa/presentation/detail_kajian.dart';
import 'package:bitaqwa/presentation/ambil_thumbnail.dart';

class KajianScreen extends StatefulWidget {
  const KajianScreen({super.key});

  @override
  State<KajianScreen> createState() => _KajianScreenState();
}

class _KajianScreenState extends State<KajianScreen> {
  final List<VideoKajian> listKajian = kajianData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4FB),

      appBar: AppBar(
        title: const Text(
          'Video Kajian',
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
              title: 'Jadwal Kajian',
              icon: Icons.menu_book,
              description: 'Temukan kajian Islam dan tambah ilmu setiap hari.',
            ),

            const SizedBox(height: 25),

            const Text(
              'Kajian Terbaru',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 15),

            // DAFTAR KAJIAN
            ...listKajian.map((kajian) {
              return Container(
                margin: const EdgeInsets.only(bottom: 15),

                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),

                child: InkWell(
                  borderRadius: BorderRadius.circular(18),

                  // NAVIGASI KE DETAIL
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailKajianScreen(kajian: kajian),
                      ),
                    );
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(12),

                    child: Row(
                      children: [
                        // THUMBNAIL OTOMATIS DARI YOUTUBE
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SizedBox(
                            width: 120,
                            height: 70,
                            child: Image.network(
                              getYoutubeThumbnail(kajian.youtubeUrl),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  color: const Color(0xFFEDE6F4),
                                  child: const Icon(
                                    Icons.image_not_supported,
                                    color: Color(0xFF645477),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),

                        const SizedBox(width: 14),

                        // INFORMASI KAJIAN
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                kajian.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              const SizedBox(height: 6),

                              Text(
                                kajian.ustadz,
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 12,
                                ),
                              ),

                              const SizedBox(height: 5),

                              Text(
                                kajian.duration,
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 5),

                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 15,
                          color: Color(0xFF645477),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
