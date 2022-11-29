import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/api/end_points.dart';

import '../../../../core/models/response_message.dart';
import '../../../login/data/models/login_data_model.dart';
import '../../../login/domain/entities/login_domain_model.dart';
import '../models/register_data_model.dart';

abstract class BaseRegistrationDataSource {
  Future<RegistrationDataModel> postRegisterData(RegistrationUserModel user);

  Future<LoginModel> updateProfileData(RegistrationUserModel user);

  Future<LoginModel> updateStoreProfileData(String token);

  Future<StatusResponse> sendCodeToEmail(String email);

  Future<StatusResponse> checkCode(String code);

  Future<StatusResponse> resetPassword(List<String> passwords);
}

class RegistrationDataSource implements BaseRegistrationDataSource {
  final BaseApiConsumer apiConsumer;

  RegistrationDataSource(this.apiConsumer);

  @override
  Future<RegistrationDataModel> postRegisterData(
      RegistrationUserModel user) async {
    final response = await apiConsumer.newPost(
      EndPoints.registerUrl,
      body: user.userType == '1'
          ? await user.toJsonRegisterUser()
          : await user.toJsonRegisterProject(),
      formDataIsEnabled: true,
    );
    return RegistrationDataModel.fromJson(jsonDecode(response.data));
  }

  @override
  Future<LoginModel> updateProfileData(RegistrationUserModel user) async {
    Response response = await apiConsumer.newPost(EndPoints.updateProfileUrl,
        body: await user.updateUserProfileToJson(),
        formDataIsEnabled: true,
        options: Options(headers: {"Authorization": user.token}));
    return LoginDataModel.fromJson(jsonDecode(response.data));
  }

  @override
  Future<LoginModel> updateStoreProfileData(String token) async {
    final response = await apiConsumer.get(
      EndPoints.updateStoreProfileUrl,
      options: Options(
        headers: {"Authorization": token},
      ),
    );
    return LoginDataModel.fromJson(response);
  }

  @override
  Future<StatusResponse> sendCodeToEmail(String email) async {
    final response = await apiConsumer.post(
      EndPoints.sendCodeToEmailUrl,
      body: {"email": email},
    );
    return StatusResponse.fromJson(response);
  }

  @override
  Future<StatusResponse> checkCode(String code) async {
    final response = await apiConsumer.post(
      EndPoints.checkCodeUrl,
      body: {"code": code},
    );
    return StatusResponse.checkCodeFromJson(response);
  }

  @override
  Future<StatusResponse> resetPassword(List<String> passwords) async {
    final response = await apiConsumer.post(
      EndPoints.resetPasswordUrl,
      body: {
        "code": passwords[0],
        'password': passwords[1],
        'password_confirmation': passwords[1],
      },
    );
    return StatusResponse.fromJson(response);
  }
}
