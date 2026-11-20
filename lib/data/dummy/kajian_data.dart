// File: lib/data/dummy/kajian_data.dart

class VideoKajian {
  final String title;
  final String ustadz;
  final String youtubeUrl;
  final String duration;

  const VideoKajian({
    required this.title,
    required this.ustadz,
    required this.youtubeUrl,
    required this.duration,
  });
}

final List<VideoKajian> kajianData = [
  const VideoKajian(
    title: 'Jangan Lalai',
    ustadz: 'Ustadz Syafiq Riza Basalamah',
    youtubeUrl: 'https://youtu.be/rpFgPPxymmM?si=8ijl1DNmpy2BrGue',
    duration: '13:42',
  ),
  const VideoKajian(
    title: 'Tanya Jawab Seputar Islam',
    ustadz: 'Ustadz Khalid Basalamah',
    youtubeUrl: 'https://www.youtube.com/watch?v=7dOpAJYLRHI',
    duration: '33:44',
  ),
  const VideoKajian(
    title: 'Menjaga Kesehatan Anak',
    ustadz: 'Ustadz Muhammad Abduh Tuasikal',
    youtubeUrl: 'https://www.youtube.com/watch?v=_KUiFLbcXwE',
    duration: '43:37',
  ),
  const VideoKajian(
    title: 'Al-Qonthoroh (Jembatan setelah Siroth)',
    ustadz: 'Ustadz Firanda Andirja',
    youtubeUrl: 'https://www.youtube.com/watch?v=m7EIvELSfhc',
    duration: '38:18',
  ),
  const VideoKajian(
    title: 'Adab-adab Dalam Menuntut Ilmu',
    ustadz: 'Ustadz Yazid bin Abdul Qadir Jawas',
    youtubeUrl: 'https://www.youtube.com/watch?v=sjVGGo2Jvdk',
    duration: '16:37',
  ),
];
