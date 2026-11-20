import 'package:bitaqwa/enum/kategori_doa_enum.dart';

extension DoaCategoryExtension on DoaCategory {
  String get title {
    switch (this) {
      case DoaCategory.makananMinuman:
        return "Makanan & Minuman";

      case DoaCategory.pagiMalam:
        return "Pagi & Malam";

      case DoaCategory.rumah:
        return "Rumah";

      case DoaCategory.perjalanan:
        return "Perjalanan";

      case DoaCategory.sholat:
        return "Sholat";

      case DoaCategory.etikaBaik:
        return "Etika Baik";
    }
  }

  String get image {
    switch (this) {
      case DoaCategory.makananMinuman:
        return "assets/images/frame_11.png";

      case DoaCategory.pagiMalam:
        return "assets/images/frame_13.png";

      case DoaCategory.rumah:
        return "assets/images/frame_12.png";

      case DoaCategory.perjalanan:
        return "assets/images/frame_10.png";

      case DoaCategory.sholat:
        return "assets/images/frame_14.png";

      case DoaCategory.etikaBaik:
        return "assets/images/frame_15.png";
    }
  }
}
