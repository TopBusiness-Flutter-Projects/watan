// To parse this JSON data, do
//
//     final bloggs = bloggsFromJson(jsonString);

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

import '../../data/models/register_data_model.dart';

RegistrationDomainModel registrationDomainModelFromJson(String str) =>
    RegistrationDataModel.fromJson(json.decode(str));

String registrationDomainModelToJson(RegistrationDataModel data) =>
    json.encode(data.toJson());

class RegistrationDomainModel extends Equatable {
  const RegistrationDomainModel({
    required this.data,
    required this.message,
    required this.code,
  });

  final RegistrationDataData? data;
  final String? message;
  final int? code;

  @override
  List<Object?> get props => [
        data,
        message,
        code,
      ];
}

class RegistrationDomainData extends Equatable {
  const RegistrationDomainData({
    required this.user,
    required this.accessToken,
    required this.tokenType,
  });

  final RegistrationUserModel? user;
  final String? accessToken;
  final String? tokenType;

  @override
  List<Object?> get props => [
        user,
        accessToken,
        tokenType,
      ];
}

class RegistrationUser extends Equatable {
  RegistrationUser({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.password,
    this.whatsapp,
    this.status,
    this.imagePath,
    this.image,
    this.userType,
    this.facebook,
    this.instagram,
    this.twitter,
    this.snapchat,
    this.latitude,
    this.longitude,
    this.token,
  });

  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? password;
  final String? whatsapp;
  final String? status;
  final String? imagePath;
  final String? image;
  dynamic userType;
  final String? facebook;
  final String? instagram;
  final String? twitter;
  final String? snapchat;
  final double? latitude;
  final double? longitude;
  final String? token;

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
        imagePath,
        userType,
        facebook,
        instagram,
        twitter,
        snapchat,
        latitude,
        longitude,
        token,
      ];
}
