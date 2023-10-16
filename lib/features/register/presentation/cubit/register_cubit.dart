import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:elwatn/core/utils/app_strings.dart';
import 'package:elwatn/core/utils/toast_message_method.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/map_failure_message.dart';
import '../../../../core/utils/translate_text_method.dart';
import '../../../login/data/models/login_data_model.dart';
import '../../../login/domain/entities/login_domain_model.dart';
import '../../data/models/register_data_model.dart';
import '../../domain/use_cases/check_code_use_case.dart';
import '../../domain/use_cases/post_register_user_use_case.dart';
import '../../domain/use_cases/reset_password_use_case.dart';
import '../../domain/use_cases/send_code_use_case.dart';
import '../../domain/use_cases/update_profile_use_case.dart';
import '../../domain/use_cases/update_store_profile_use_case.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(
    this.postRegisterUserUseCase,
    this.updateProfileUseCase,
    this.updateStoreProfileUseCase,
    this.sendCodeUseCase,
    this.checkCodeUseCase,
    this.resetPasswordUseCase,
  ) : super(RegisterInitial());

  bool choose1 = false;
  bool choose2 = false;
  int userType = 0;
  XFile? image;
  String checkCodeOfEmail = '';
  final picker = ImagePicker();
  String imageLink = "";
  String registerBtn = "";
  String token = "";
  double latitude = 0.0;
  double longitude = 0.0;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController whatsappController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController instaController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController snapController = TextEditingController();

  final PostRegisterUserUseCase postRegisterUserUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final UpdateStoreProfileUseCase updateStoreProfileUseCase;
  final SendCodeUseCase sendCodeUseCase;
  final CheckCodeUseCase checkCodeUseCase;
  final ResetPasswordUseCase resetPasswordUseCase;

  putDataToEdit(LoginDataModel userModel) {
    registerBtn = "update";
    if (userModel.data!.user!.phone != null) {
      registerBtn = "update";
      token = userModel.data!.accessToken!;
      userType = userModel.data!.user!.userType!;
    } else {
      token = userModel.data!.accessToken!;
      registerBtn = "save";
    }
    emailController.text = userModel.data!.user!.email!;
    passwordController.text = "";
    nameController.text = userModel.data!.user!.name ?? "";
    phoneController.text = userModel.data!.user!.phone!.contains('+964')
        ? userModel.data!.user!.phone!.substring(4)
        : userModel.data!.user!.phone!.contains('+20')
            ? userModel.data!.user!.phone!.substring(3)
            : userModel.data!.user!.phone!;
    whatsappController.text = userModel.data!.user!.whatsapp!.contains('+964')
        ? userModel.data!.user!.whatsapp!.substring(4)
        : userModel.data!.user!.whatsapp!.contains('+20')
        ? userModel.data!.user!.whatsapp!.substring(3)
        : userModel.data!.user!.whatsapp!;
    facebookController.text = userModel.data!.user!.facebook ?? "";
    instaController.text = userModel.data!.user!.instagram ?? "";
    twitterController.text = userModel.data!.user!.twitter ?? "";
    snapController.text = userModel.data!.user!.snapchat ?? "";
    imageLink = userModel.data!.user!.image ?? "";
  }

  clearData() {}

  updateLoginStoreData(String token) async {
    final response = await updateStoreProfileUseCase(token);
    response.fold(
      (l) => emit(
        UpdateStoreDataFailure(),
      ),
      (loginModel) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(loginModel)).then(
          (value) {
            emit(UpdateStoreDataSuccessfully());
            Future.delayed(
              const Duration(seconds: 2),
              () {
                emit(RegisterInitial());
              },
            );
          },
        );
      },
    );
  }

  changeUser(bool ch1, bool ch2, int type) {
    choose1 = ch1;
    choose2 = ch2;
    userType = type;
    emit(RegisterUserChanged());
    Future.delayed(Duration(milliseconds: 250), () {
      emit(RegisterUserChangedDone());
    });
  }

  postRegisterData() async {
    emit(RegisterLoading());
    Either<Failure, RegistrationDataModel> response =
        await postRegisterUserUseCase(
      RegistrationUserModel(
        userType: userType.toString(),
        image: image != null ? image!.path : null,
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text.length == 11
            ? AppStrings.phoneCode + phoneController.text.substring(1)
            : AppStrings.phoneCode + phoneController.text,
        whatsapp: whatsappController.text.length == 11
            ? AppStrings.phoneCode + whatsappController.text.substring(1)
            : AppStrings.phoneCode + whatsappController.text,
        password: passwordController.text,
        longitude: longitude,
        latitude: latitude,
        facebook: facebookController.text,
        instagram: instaController.text,
        twitter: twitterController.text,
        snapchat: snapController.text,
      ),
    );
    response.fold(
      (failure) {
        emit(RegisterFailure(
            message: MapFailureMessage.mapFailureToMessage(failure)));
      },
      (userModel) async {
        userModel.code == 200;

        if (userModel.code == 200) {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('user', jsonEncode(userModel)).then((value) {
            confirmPasswordController.clear();
            emit(RegisterLoaded(userModel));
            Future.delayed(
              const Duration(seconds: 2),
              () {
                emit(RegisterInitial());
              },
            );
          });
        } else if (userModel.code == 409) {
          emit(RegisterValidator(409));
        } else {
          emit(RegisterValidator(410));
        }
      },
    );
  }

  updateProfileData() async {
    emit(UpdateProfileLoading());
    Either<Failure, LoginModel> response = await updateProfileUseCase(
      RegistrationUserModel(
        name: nameController.text,
        phone: phoneController.text.length == 11
            ? AppStrings.phoneCode + phoneController.text.substring(1)
            : AppStrings.phoneCode + phoneController.text,
        whatsapp: whatsappController.text,
        email: emailController.text,
        password: passwordController.text,
        userType: userType.toString(),
        image: image != null ? image!.path : null,
        token: token,
      ),
    );
    response.fold(
      (failure) {
        return UpdateProfileFailure(
            message: MapFailureMessage.mapFailureToMessage(failure));
      },
      (statusResponse) {
        if (statusResponse.code == 200) {
          print("update Successfully");
          updateLoginStoreData(statusResponse.data!.accessToken!);
        } else {
          print("Error");
          print(statusResponse.code);
          print(statusResponse.message);
        }
        return UpdateProfileLoaded(statusResponse);
      },
    );
  }

  //////////////////send OTP///////////////////

  String phoneNumber = '';
  String mySmsCode = '';
  String smsCode = '';
  String time = '';
  int seconds = 60;
  Timer? timer;
  FirebaseAuth _mAuth = FirebaseAuth.instance;
  String? verificationId;
  int? resendToken;

  sendSmsCode(BuildContext context) async {
    emit(SendCodeLoading());
    _mAuth.setSettings(forceRecaptchaFlow: true);
    _mAuth.verifyPhoneNumber(
      forceResendingToken: this.resendToken,
      phoneNumber: phoneNumber,
      // timeout: Duration(seconds: 1),
      verificationCompleted: (PhoneAuthCredential credential) {
        smsCode = credential.smsCode!;
        this.verificationId = credential.verificationId;
        print("verificationId=>${verificationId}");
        emit(OnSmsCodeSent(smsCode));
        verifySmsCode(smsCode, context);
      },
      verificationFailed: (FirebaseAuthException e) {
        emit(CheckCodeInvalidCode());
        print("Errrrorrrrr : ${e.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        this.resendToken = resendToken;
        this.verificationId = verificationId;
        print("verificationId=>${verificationId}");
        emit(OnSmsCodeSent(''));
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print('kokokokokokok');
        this.verificationId = verificationId;
      },
    );
  }

  verifySmsCode(String smsCode, BuildContext context) async {
    print(smsCode);
    print(verificationId);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationId!,
      smsCode: smsCode,
    );
    await _mAuth.signInWithCredential(credential).then((value) {
      print('LoginSuccess');
      emit(CheckCodeSuccessfully());
      stopTimer();
    }).catchError((error) {
      toastMessage(translateText(AppStrings.invalidCodeMessage, context), context);
      print('phone auth =>${error.toString()}');
    });
  }

  startTimer() {


    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        time = '${seconds}'.padLeft(2, '0');
        print(seconds);
        emit(OnTimerChanged('00:${time}'));
        Future.delayed(Duration(milliseconds: 250), () {
          emit(OnTimerChangedAgain());
        });
      } else {
        time = '';
        seconds = 60;
        emit(OnTimerChanged(''));
        timer.cancel();
      }
    });
  }

  stopTimer() {
    timer!.cancel();
  }

//////////////// send Email ///////////////////
  sendCodeToEmail(String email) async {
    emit(SendCodeLoading());
    final response = await sendCodeUseCase(email);
    response.fold((l) => emit(SendCodeFailure()), (r) {
      if (r.code == 200) {
        emit(SendCodeSuccessfully());
        Future.delayed(Duration(seconds: 2), () {
          emit(RegisterInitial());
        });
      } else if (r.code == 422) {
        emit(SendCodeInvalidEmail());
        Future.delayed(Duration(milliseconds: 700), () {
          emit(RegisterInitial());
        });
      }
    });
  }

  checkCode(String phone, context) async {
    emit(CheckCodeLoading());
    final response = await checkCodeUseCase(phone);
    response.fold((l) => emit(CheckCodeFailure()), (r) {
      if (r.code == 200) {
        phoneNumber = phone;
        // checkCodeOfEmail = r.checkCode;
        emit(CheckCodeSuccessfully());
        sendSmsCode(context);
        Future.delayed(Duration(seconds: 2), () {
          emit(RegisterInitial());
        });
      } else if (r.code == 422) {
        emit(CheckCodeInvalidCode());
        Future.delayed(Duration(seconds: 2), () {
          emit(RegisterInitial());
        });
      }
    });
  }

  resetPassword(String password) async {
    emit(ResetPasswordLoading());
    final response = await resetPasswordUseCase([phoneNumber, password]);
    response.fold((l) => emit(ResetPasswordFailure()), (r) {
      if (r.code == 200) {
        emit(ResetPasswordSuccessfully());
        Future.delayed(const Duration(seconds: 2), () {
          emit(RegisterInitial());
        });
      } else if (r.code == 422) {
        emit(ResetPasswordInvalidCode());
        Future.delayed(Duration(seconds: 2), () {
          emit(RegisterInitial());
        });
      }
    });
  }
}
