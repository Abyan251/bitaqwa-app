import 'package:flutter/material.dart';
import 'package:bitaqwa/data/dummy/kajian_data.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class DetailKajianScreen extends StatefulWidget {
  final VideoKajian kajian;

  const DetailKajianScreen({super.key, required this.kajian});

  @override
  State<DetailKajianScreen> createState() => _DetailKajianScreenState();
}

class _DetailKajianScreenState extends State<DetailKajianScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final String? videoId = YoutubePlayerController.convertUrlToId(
      widget.kajian.youtubeUrl,
    );

    _controller = YoutubePlayerController.fromVideoId(
      videoId: videoId ?? '',
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        playsInline: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      builder: (context, player) {
        return Scaffold(
          backgroundColor: const Color(0xFFF9F4FB),
          appBar: AppBar(
            title: Text(
              widget.kajian.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Pemutar Video YouTube di Atas Halaman Detail
                player,
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.kajian.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(
                            Icons.person,
                            size: 18,
                            color: Color(0xFF645477),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            widget.kajian.ustadz,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF645477),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.access_time,
                            size: 18,
                            color: Colors.grey,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            widget.kajian.duration,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 35),
                      const Text(
                        "Deskripsi Kajian",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Simak kajian Islam pilihan ini dengan seksama untuk menambah wawasan ilmu agama, memperbaiki amal ibadah, dan memperkuat keimanan kita sehari-hari.",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
