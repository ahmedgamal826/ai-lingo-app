/// Centralized asset path helpers.
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

  static const String search = '$iconsPath/search.svg';
  static const String slidersHorizontal = '$iconsPath/sliders-horizontal.svg';
  static const String layoutGrid = '$iconsPath/layout-grid.svg';
  static const String clipboardCheck = '$iconsPath/clipboard-check.svg';
  static const String messagesSquare = '$iconsPath/messages-square.svg';
  static const String bell = '$iconsPath/bell.svg';
  static const String userRound = '$iconsPath/user-round.svg';
  static const String arrowLeft = '$iconsPath/arrow-left.svg';
  static const String send = '$iconsPath/send.svg';
  static const String chevronDown = '$iconsPath/chevron-down.svg';
  static const String externalLink = '$iconsPath/external-link.svg';
  static const String messageCheck = '$iconsPath/message-check.svg';
  static const String checkCircle = '$iconsPath/check-circle.svg';
}
