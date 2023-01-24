import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/map_failure_message.dart';
import '../../../home_page/domain/entities/device_token_model.dart';
import '../../../home_page/domain/use_cases/send_device_token_use_case.dart';
import '../../../register/domain/use_cases/update_store_profile_use_case.dart';
import '../../data/models/login_data_model.dart';
import '../../domain/entities/login_domain_model.dart';
import '../../domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(
      {required this.sendDeviceTokenUseCase,
      required this.updateStoreProfileUseCase,
      required this.postLoginUseCase})
      : super(LoginInitial());

  final PostLoginUseCase postLoginUseCase;
  LoginDataModel? userLoginModel;
  final UpdateStoreProfileUseCase updateStoreProfileUseCase;
  String token = '';
  bool isNewUser = false;
  final SendDeviceTokenUseCase sendDeviceTokenUseCase;

  Future<void> postLoginData(
      {required String email, required String password}) async {
    emit(LoginLoading());
    Either<Failure, LoginDataModel> response =
        await postLoginUseCase([email, password]);
    emit(
      response.fold(
        (failure) => LoginLoadedError(
            message: MapFailureMessage.mapFailureToMessage(failure)),
        (loginModel) {
          userLoginModel = loginModel;
          userLoginModel!.code == 200 ? storeUser(loginModel) : null;
          return LoginLoaded(loginModel: loginModel);
        },
      ),
    );
  }

  storeUser(LoginModel loginModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String softwareType = '';
    await prefs.setString('user', jsonEncode(loginModel));
    String? token = await FirebaseMessaging.instance.getToken();
    if (Platform.isAndroid) {
      softwareType = 'android';
      sendDeviceTokenUseCase(
        DeviceTokenModel(
          deviceToken: token,
          softwareType: softwareType,
          userToken: loginModel.data!.accessToken,
        ),
      );
      print('----------------- no user ---------------------');
    } else if (Platform.isIOS) {
      softwareType = 'ios';
      sendDeviceTokenUseCase(
        DeviceTokenModel(
          deviceToken: token,
          softwareType: softwareType,
          userToken: loginModel.data!.accessToken,
        ),
      );
      print('----------------- no user ---------------------');
    }
  }

  updateLoginStoreData() async {
    emit(LoginLoading());
    final response = await updateStoreProfileUseCase(token);
    response.fold(
      (l) => emit(
        UpdateStoreDataFailure(),
      ),
      (loginModel) async {
        isNewUser = true;
        userLoginModel = loginModel as LoginDataModel?;
        storeUser(loginModel);
        emit(LoginLoaded(loginModel: loginModel));
      },
    );
  }

  socialLoginSuccessfully(String token) {
    this.token = "Bearer $token";
    emit(SocialLoginSuccess());
  }

  loginSuccessfully() {
    emit(LoginInitial());
  }
}
