class StatusResponse {
  late int code = 0;
  late String checkCode = '';
  late String message = "";
  Message? messages;

  StatusResponse();

  StatusResponse.fromJson(Map<String, dynamic> json) {
    code = json['code'] as int;
    message = json['code'] == 200 ? json['message'].toString() : "";
    messages =
        json['code'] != 200 ? Message.fromJson(json["message"]) : Message();
  }
  StatusResponse.checkCodeFromJson(Map<String, dynamic> json) {
    code = json['code'] as int;
    checkCode = json['validation_code'] ?? "";
    message = json['code'] == 200 ? json['message'].toString() : "";
    messages =
        json['code'] != 200 ? Message.fromJson(json["message"]) : Message();
  }
}

class Message {
  Message({
    this.phone,
    this.email,
  });

  List<String>? phone;
  List<String>? email;

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        phone: json["phone"] != null
            ? List<String>.from(json["phone"].map((x) => x))
            : [],
        email: json["email"] != null
            ? List<String>.from(json["email"].map((x) => x))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "phone": List<dynamic>.from(phone!.map((x) => x)),
        "email": List<dynamic>.from(email!.map((x) => x)),
      };
}
