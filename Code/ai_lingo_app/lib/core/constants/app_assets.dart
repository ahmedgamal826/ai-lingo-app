/// Centralized asset path helpers.
///
/// Only declare paths for folders that exist. Add concrete files here
/// when design assets are dropped into `assets/`.
class AppAssets {
  AppAssets._();

  static const String imagesPath = 'assets/images';
  static const String iconsPath = 'assets/icons';
  static const String illustrationsPath = 'assets/illustrations';
  static const String animationsPath = 'assets/animations';
  static const String fontsPath = 'assets/fonts';

  static String image(String fileName) => '$imagesPath/$fileName';
  static String icon(String fileName) => '$iconsPath/$fileName';
  static String illustration(String fileName) => '$illustrationsPath/$fileName';
  static String animation(String fileName) => '$animationsPath/$fileName';
}
