import '../../domain/entities/login_domain_model.dart';

class LoginDataModel extends LoginModel {
  const LoginDataModel({super.data, super.message, super.code});

  factory LoginDataModel.fromJson(Map<String, dynamic> json) => LoginDataModel(
        data: json["data"] != null
            ? UserDataModel.fromJson(json["data"])
            : const UserDataModel(),
        message: json["message"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "message": message,
        "code": code,
      };
}

class UserDataModel extends UserData {
  const UserDataModel({super.user, super.accessToken, super.tokenType});

  factory UserDataModel.fromJson(Map<String, dynamic> json) => UserDataModel(
        user: UserModel.fromJson(json["user"]),
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "user": user!.toJson(),
        "access_token": accessToken,
        "token_type": tokenType,
      };
}

class UserModel extends User {
  UserModel(
      {super.id,
      super.name,
      super.phone,
      super.email,
      super.password,
      super.whatsapp,
      super.status,
      super.image,
      super.fileImage,
      super.userType,
      super.facebook,
      super.instagram,
      super.twitter,
      super.snapchat,
      super.latitude,
      super.packagesBalance,
      super.longitude});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        whatsapp: json["whatsapp"],
        status: json["status"],
        image: json["image"],
        fileImage: json["fileImage"],
        userType: json["user_type"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        twitter: json["twitter"],
        packagesBalance: json["packages_balance"] ?? 0,
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
        "fileImage": fileImage,
        "user_type": userType,
        "facebook": facebook,
        "instagram": instagram,
        "twitter": twitter,
        "snapchat": snapchat,
        "latitude": latitude,
        "longitude": longitude,
        "packages_balance": packagesBalance,
      };
}
