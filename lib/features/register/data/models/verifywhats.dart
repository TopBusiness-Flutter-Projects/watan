class WhatsAppResponseCodeModel {
  String? message;
  int? code;
  WhatsAppResponseCodeModel({this.message, this.code});

  factory WhatsAppResponseCodeModel.fromJson(Map<String, dynamic> json) =>
      WhatsAppResponseCodeModel(message: json["message"], code: json['code']);

  Map<String, dynamic> toJson() => {"message": message, "code": code};
}
