import 'package:dio/dio.dart';

import '../../domain/entities/register_domain_model.dart';

class RegistrationDataModel extends RegistrationDomainModel {
  const RegistrationDataModel(
      {required super.data, required super.message, required super.code});

  factory RegistrationDataModel.fromJson(Map<String, dynamic> json) =>
      RegistrationDataModel(
        data: json["data"] != null
            ? RegistrationDataData.fromJson(json["data"])
            : RegistrationDataData(),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "code": code,
      };
}

class RegistrationDataData extends RegistrationDomainData {
  const RegistrationDataData({super.user, super.accessToken, super.tokenType});

  factory RegistrationDataData.fromJson(Map<String, dynamic> json) =>
      RegistrationDataData(
        user: RegistrationUserModel.fromJson(json["user"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class RegistrationUserModel extends RegistrationUser {
  RegistrationUserModel({
    super.id,
    super.name,
    super.phone,
    super.email,
    super.password,
    super.whatsapp,
    super.status,
    super.imagePath,
    super.image,
    super.userType,
    super.facebook,
    super.instagram,
    super.twitter,
    super.snapchat,
    super.latitude,
    super.longitude,
    super.token,
  });

  factory RegistrationUserModel.fromJson(Map<String, dynamic> json) =>
      RegistrationUserModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        whatsapp: json["whatsapp"],
        status: json["status"],
        imagePath: json["imagePath"],
        image: json["image"],
        userType: json["user_type"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        snapchat: json["snapchat"],
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
        "whatsapp": whatsapp,
        "status": status,
        "image": image,
        "imagePath": imagePath,
        "user_type": userType,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "snapchat": snapchat,
        "latitude": latitude,
        "longitude": longitude,
      };

  Future<Map<String, dynamic>> toJsonRegisterUser() async => {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
        "whatsapp": whatsapp,
        "image": await MultipartFile.fromFile(image!),
        "user_type": userType,
      };

  Future<Map<String, dynamic>> toJsonRegisterProject() async => {
        "name": name,
        "phone": phone,
        "email": email,
        "password": password,
        "whatsapp": whatsapp,
        "image": await MultipartFile.fromFile(image!),
        "user_type": userType,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "snapchat": snapchat,
        "latitude": latitude,
        "longitude": longitude,
      };

  Future<Map<String, dynamic>> updateUserProfileToJson() async => {
        "name": name,
        "phone": phone,
        "email": email,
        if (password != null) ...{
          "password": password,
        },
        "whatsapp": whatsapp,
        if (image != null) ...{
          "image": await MultipartFile.fromFile(image!),
        },
        "user_type": userType,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "snapchat": snapchat,
        "latitude": latitude,
        "longitude": longitude,
      };
}
