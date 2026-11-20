String getAssetPath() {
  final int hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return 'assets/images/frame_8.png';
  } else if (hour >= 13 && hour < 18) {
    return 'assets/images/frame_7.png';
  } else {
    return 'assets/images/frame_9.png';
  }
}

String nextPrayerTime() {
  final int hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return 'Dzuhur';
  } else if (hour >= 13 && hour < 18) {
    return 'Ashar';
  } else if (hour >= 18 && hour < 20) {
    return 'Maghrib';
  } else if (hour >= 20 && hour < 24) {
    return 'Isya';
  } else {
    return 'Subuh';
  }
}
