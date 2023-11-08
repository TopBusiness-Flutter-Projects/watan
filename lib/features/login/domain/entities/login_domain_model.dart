import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/login_data_model.dart';

LoginModel loginFromJson(String str) =>
    LoginDataModel.fromJson(json.decode(str));

String loginToJson(LoginDataModel data) => json.encode(data.toJson());

class LoginModel extends Equatable {
  const LoginModel({
    required this.data,
    required this.message,
    required this.code,
  });

  final UserDataModel? data;
  final String? message;
  final int? code;

  @override
  List<Object?> get props => [data, message, code];
}

class UserData extends Equatable {
  const UserData({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  final UserModel? user;
  final String? accessToken;
  final String? tokenType;

  @override
  List<Object?> get props => [user, accessToken, tokenType];
}

class User extends Equatable {
  User({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.whatsapp,
    this.status,
    this.image,
    this.fileImage,
    this.userType,
    this.facebook,
    this.instagram,
    this.twitter,
    this.snapchat,
    this.latitude,
    this.longitude,
    this.packagesBalance,
  });

  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? password;
  final String? whatsapp;
  final String? status;
  final String? image;
  final FormData? fileImage;
  final int? userType;
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? snapchat;
  dynamic latitude;
  dynamic longitude;
  final int? packagesBalance;

  @override
  List<Object?> get props => [
        id,
        name,
        phone,
        email,
        password,
        whatsapp,
        status,
        image,
        fileImage,
        userType,
        facebook,
        instagram,
        twitter,
        snapchat,
        latitude,
        longitude,
        packagesBalance,
      ];
}
