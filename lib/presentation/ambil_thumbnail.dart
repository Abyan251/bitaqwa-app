String getYoutubeThumbnail(String url) {
  final uri = Uri.parse(url);

  String? videoId;

  if (uri.host.contains('youtu.be')) {
    videoId = uri.pathSegments.first;
  } else if (uri.host.contains('youtube.com')) {
    if (uri.pathSegments.isNotEmpty &&
        (uri.pathSegments.first == 'live' ||
            uri.pathSegments.first == 'shorts' ||
            uri.pathSegments.first == 'embed')) {
      videoId = uri.pathSegments.length > 1 ? uri.pathSegments[1] : null;
    } else {
      videoId = uri.queryParameters['v'];
    }
  }

  if (videoId == null || videoId.isEmpty) {
    return '';
  }

  return 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
}
