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

  // Icons used by Home
  static const String trophy = '$iconsPath/trophy.svg';
  static const String bell = '$iconsPath/bell.svg';
  static const String sparkles = '$iconsPath/sparkles.svg';
  static const String utensils = '$iconsPath/utensils.svg';
  static const String briefcaseBusiness = '$iconsPath/briefcase-business.svg';
  static const String bookmark = '$iconsPath/bookmark.svg';
  static const String volume2 = '$iconsPath/volume-2.svg';

  // Bottom navigation
  static const String house = '$iconsPath/house.svg';
  static const String messagesSquare = '$iconsPath/messages-square.svg';
  static const String bookOpen = '$iconsPath/book-open-nav.svg';
  static const String chartNoAxesColumn = '$iconsPath/chart-no-axes-column.svg';
  static const String userRound = '$iconsPath/user-round.svg';

  // Leaderboard
  static const String arrowLeft = '$iconsPath/arrow-left.svg';
  static const String goldMedal = '$iconsPath/gold_medal.png';
  static const String silverMedal = '$iconsPath/silver_medal.png';
  static const String bronzeMedal = '$iconsPath/bronze_medal.png';
}
