// To parse this JSON data, do
//
//     final deviceTokenModel = deviceTokenModelFromJson(jsonString);

import 'dart:convert';

DeviceTokenModel deviceTokenModelFromJson(String str) => DeviceTokenModel.fromJson(json.decode(str));

String deviceTokenModelToJson(DeviceTokenModel data) => json.encode(data.toJson());

class DeviceTokenModel {
  DeviceTokenModel({
    this.userToken,
    this.deviceToken,
    this.softwareType,
  });

  String? userToken;
  String? deviceToken;
  String? softwareType;

  factory DeviceTokenModel.fromJson(Map<String, dynamic> json) => DeviceTokenModel(
    deviceToken: json["token"],
    softwareType: json["software_type"],
  );

  Map<String, dynamic> toJson() => {
    "token": deviceToken,
    "software_type": softwareType,
  };
}
