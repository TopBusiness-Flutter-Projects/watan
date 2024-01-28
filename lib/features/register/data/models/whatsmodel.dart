class WhatsAppResponseModel {
  String? message;
  int? otp;
  int? code;
  WhatsAppResponseModel({this.message, this.otp, this.code});

  factory WhatsAppResponseModel.fromJson(Map<String, dynamic> json) =>
      WhatsAppResponseModel(
          message: json["message"], otp: json["otp"] ?? 0, code: json['code']);

  Map<String, dynamic> toJson() =>
      {"message": message, "otp": otp, "code": code};
}
