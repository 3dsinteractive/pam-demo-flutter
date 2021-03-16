// ignore_for_file: non_constant_identifier_names

class NotificationModel {
  final String Title;
  final String Message;
  final String CreatedDate;
  final bool isRead;

  NotificationModel({
    required this.Title,
    required this.Message,
    required this.CreatedDate,
    required this.isRead,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> rawJson) {
    return NotificationModel(
      Title: rawJson["title"] ?? "",
      Message: rawJson["message"] ?? "",
      CreatedDate: rawJson["created_date"] ?? "",
      isRead: rawJson["is_read"] ?? false,
    );
  }

  static List<NotificationModel> toList(List<Map<String, dynamic>>? rawItems) {
    if (rawItems == null) {
      return [];
    }

    List<NotificationModel> items = [];
    for (int i = 0; i < rawItems.length; i++) {
      items.add(NotificationModel.fromJson(rawItems[i]));
    }

    return items;
  }
}
