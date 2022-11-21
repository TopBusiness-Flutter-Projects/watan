// To parse this JSON data, do
//
//     final notificationsModel = notificationsModelFromJson(jsonString);

import 'dart:convert';

NotificationsModel notificationsModelFromJson(String str) =>
    NotificationsModel.fromJson(json.decode(str));

String notificationsModelToJson(NotificationsModel data) =>
    json.encode(data.toJson());

class NotificationsModel {
  NotificationsModel({
    this.data,
  });

  List<NotificationsDatum>? data;

  factory NotificationsModel.fromJson(Map<String, dynamic> json) =>
      NotificationsModel(
        data: List<NotificationsDatum>.from(
            json["data"].map((x) => NotificationsDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class NotificationsDatum {
  NotificationsDatum({
    this.id,
    this.userId,
    this.title,
    this.message,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? title;
  String? message;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory NotificationsDatum.fromJson(Map<String, dynamic> json) =>
      NotificationsDatum(
        id: json["id"],
        userId: json["user_id"] != null ? json["user_id"] : 0,
        title: json["title"] != null ? json["title"] : '',
        message: json["message"] != null ? json["message"] : '',
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "title": title,
        "message": message,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
