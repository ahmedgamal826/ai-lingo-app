class NotificationData {
  NotificationData({
    required this.title,
    required this.category,
    required this.description,
    required this.date,
    required this.icon,
    required this.unread,
    required this.type,
  });

  final String title;
  final String category;
  final String description;
  final String date;
  final String icon;
  bool unread;
  String type;
}
