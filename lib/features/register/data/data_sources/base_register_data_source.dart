import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/models/response_message.dart';
import '../../../login/data/models/login_data_model.dart';
import '../../../login/domain/entities/login_domain_model.dart';
import '../models/register_data_model.dart';
import '../models/verifywhats.dart';
import '../models/whatsmodel.dart';

abstract class BaseRegistrationDataSource {
  Future<RegistrationDataModel> postRegisterData(RegistrationUserModel user);

  Future<LoginModel> updateProfileData(RegistrationUserModel user);

  Future<LoginModel> updateStoreProfileData(String token);

  Future<StatusResponse> sendCodeToEmail(String email);

  Future<StatusResponse> checkCode({required String code});
  Future<WhatsAppResponseModel> whatsAppVerify({required String phoneNumber});

  Future<StatusResponse> resetPassword(List<String> passwords);
  Future<WhatsAppResponseCodeModel> verifyWhatsApp({required String code});
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
    print('User Image');
    print(user.image);
    print(user.updateUserProfileToJson());
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
  Future<StatusResponse> checkCode({required String code}) async {
    final response = await apiConsumer.post(
      EndPoints.checkCodeUrl,
      body: {"phone": code},
    );
    return StatusResponse.checkCodeFromJson(response);
  }

  @override
  Future<StatusResponse> resetPassword(List<String> passwords) async {
    print('passwords[0]');
    print(passwords[0]);
    print('passwords[1]');
    print(passwords[1]);
    final response = await apiConsumer.post(
      EndPoints.resetPasswordUrl,
      body: {
        "phone": passwords[0],
        'password': passwords[1],
        'password_confirmation': passwords[1],
      },
    );
    return StatusResponse.fromJson(response);
  }

  @override
  Future<WhatsAppResponseModel> whatsAppVerify(
      {required String phoneNumber}) async {
    final response =
        await apiConsumer.get("send-whatsapp-otp?phone=" + phoneNumber);
    return WhatsAppResponseModel.fromJson(response);
  }

  @override
  Future<WhatsAppResponseCodeModel> verifyWhatsApp(
      {required String code}) async {
    final response = await apiConsumer.get("verified-otp?otp=" + code);
    print("verified-otp?otp=" + code);
    return WhatsAppResponseCodeModel.fromJson(response);
  }
}
