import 'dart:convert';

ChatModel myRoomsFromJson(String str) =>
    ChatModel.chatModelMyRoomsFromJson(json.decode(str));

String myRoomsToJson(ChatModel data) =>
    json.encode(data.chatModelMyRoomsToJson());

class ChatModel {
  ChatModel({
    this.data,
    this.createRoom,
    this.oneRoomData,
    this.message,
    this.code,
  });

  List<MyRoomsDatum>? data;
  MyRoomsDatum? createRoom;
  MyRoomsDatum? oneRoomData;
  String? message;
  int? code;

  factory ChatModel.chatModelMyRoomsFromJson(Map<String, dynamic> json) =>
      ChatModel(
        data: json["data"] != null
            ? List<MyRoomsDatum>.from(
                json["data"].map(
                  (x) => MyRoomsDatum.myRoomsFromJson(x),
                ),
              )
            : [],
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> chatModelMyRoomsToJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.myRoomsToJson())),
        "message": message,
        "code": code,
      };

  factory ChatModel.chatModelOneRoomFromJson(Map<String, dynamic> json) =>
      ChatModel(
        oneRoomData: json["data"] != null
            ? MyRoomsDatum.oneRoomFromJson(json["data"])
            : MyRoomsDatum(),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> chatModelOneRoomToJson() => {
        "data": oneRoomData!.oneRoomToJson(),
        "message": message,
        "code": code,
      };

  factory ChatModel.chatModelOpenRoomFromJson(Map<String, dynamic> json) =>
      ChatModel(
        createRoom: json["data"] != null
            ? MyRoomsDatum.oneRoomFromJson(json["data"])
            : MyRoomsDatum(),
        message: json["message"],
        code: json["code"],
      );
  Map<String, dynamic> chatModelOpenRoomToJson() => {
        "data": createRoom,
        "message": message,
        "code": code,
      };
}

class MyRoomsDatum {
  MyRoomsDatum({
    this.id,
    this.fromUserId,
    this.toUserId,
    this.postId,
    this.projectId,
    this.fromUser,
    this.toUser,
    this.date,
    this.time,
    this.lastMessage,
    this.allMessages,
  });

  int? id;
  int? fromUserId;
  int? toUserId;
  int? postId;
  int? projectId;
  ChatUser? fromUser;
  ChatUser? toUser;
  DateTime? date;
  String? time;
  MyMessage? lastMessage;
  List<MyMessage>? allMessages;

  factory MyRoomsDatum.myRoomsFromJson(Map<String, dynamic> json) =>
      MyRoomsDatum(
        id: json["id"],
        fromUserId: json["from_user_id"],
        toUserId: json["to_user_id"],
        postId: json["post_id"] ?? 0,
        projectId: json["project_id"] ?? 0,
        fromUser: ChatUser.fromJson(json["from_user"]),
        toUser: ChatUser.fromJson(json["to_user"]),
        date: DateTime.parse(json["date"]),
        time: json["time"],
        lastMessage: json["last_message"] != null
            ? MyMessage.fromJson(json["last_message"])
            : null,
      );

  Map<String, dynamic> myRoomsToJson() => {
        "id": id,
        "from_user_id": fromUserId,
        "to_user_id": toUserId,
        "post_id": postId,
        "project_id": projectId,
        "from_user": fromUser!.toJson(),
        "to_user": toUser!.toJson(),
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "last_message": lastMessage!.toJson(),
      };

  factory MyRoomsDatum.oneRoomFromJson(Map<String, dynamic> json) =>
      MyRoomsDatum(
        id: json["id"],
        fromUserId: json["from_user_id"],
        toUserId: json["to_user_id"],
        postId: json["post_id"] ?? 0,
        projectId: json["project_id"] ?? 0,
        fromUser: ChatUser.fromJson(json["from_user"]),
        toUser: ChatUser.fromJson(json["to_user"]),
        date: DateTime.parse(json["date"]),
        time: json["time"],
        allMessages: json["messages"] != null
            ? List<MyMessage>.from(
                json["messages"].map((x) => MyMessage.fromJson(x)))
            : [],
      );

  Map<String, dynamic> oneRoomToJson() => {
        "id": id,
        "from_user_id": fromUserId,
        "to_user_id": toUserId,
        "post_id": postId,
        "project_id": projectId,
        "from_user": fromUser!.toJson(),
        "to_user": toUser!.toJson(),
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
        "messages": List<dynamic>.from(allMessages!.map((x) => x.toJson())),
      };
}

class ChatUser {
  ChatUser({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.whatsapp,
    required this.status,
    required this.image,
  });

  late int id;
  late String name;
  late String phone;
  late String email;
  late String whatsapp;
  late String status;
  late String image;

  factory ChatUser.fromJson(Map<String, dynamic> json) => ChatUser(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        whatsapp: json["whatsapp"],
        status: json["status"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "whatsapp": whatsapp,
        "status": status,
        "image": image,
      };
}

class MyMessage {
  MyMessage({
    this.type,
    this.message,
    this.file,
    this.fromUserId,
    this.toUserId,
    this.fromUser,
    this.toUser,
    this.date,
    this.time,
  });

  String? type;
  String? message;
  String? file;
  int? fromUserId;
  String? toUserId;
  ChatUser? fromUser;
  ChatUser? toUser;
  DateTime? date;
  String? time;

  factory MyMessage.fromJson(Map<String, dynamic> json) => MyMessage(
        type: json["type"],
        message: json["message"],
        file: json["file"],
        fromUserId: json["from_user_id"],
        toUserId: json["to_user_id"].toString(),
        fromUser: ChatUser.fromJson(json["from_user"]),
        toUser: ChatUser.fromJson(json["to_user"]),
        date: DateTime.parse(json["date"]),
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "file": file,
        "from_user_id": fromUserId,
        "to_user_id": toUserId,
        "from_user": fromUser!.toJson(),
        "to_user": toUser!.toJson(),
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time": time,
      };

  static Map<String, dynamic> toJsonMyMessage(MyMessage messages) {
    return {
      "type": messages.type,
      "message": messages.message,
      "file": messages.file,
      "from_user_id": messages.fromUserId,
      "to_user_id": messages.toUserId,
      "from_user": messages.fromUser!.toJson(),
      "to_user": messages.toUser!.toJson(),
      "date":
          "${messages.date!.year.toString().padLeft(4, '0')}-${messages.date!.month.toString().padLeft(2, '0')}-${messages.date!.day.toString().padLeft(2, '0')}",
      "time": messages.time,
    };
  }
}
