import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:elwatn/core/utils/translate_text_method.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/response_message.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../login/data/models/login_data_model.dart';
import '../../../login/domain/use_cases/logout_use_case.dart';
import '../../domain/use_cases/change_language_use_case.dart';
import '../../domain/use_cases/get_saved_language_use_case.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  final GetSavedLanguageUseCase getSavedLanguageUseCase;
  final ChangeLanguageUseCase changeLanguageUseCase;

  LocaleCubit({
    required this.logoutUseCase,
    required this.getSavedLanguageUseCase,
    required this.changeLanguageUseCase,
  }) : super(
          const ChangeLocaleState(
            locale: Locale(AppStrings.englishCode),
          ),
        ) {
    getStoreUser();
  }

  String logout = '';
  String currentLanguageCode = AppStrings.englishCode;
  final LogoutUseCase logoutUseCase;
  LoginDataModel? loginDataModel;
  String? token;

  Future<void> getStoreUser() async {
    token = await FirebaseMessaging.instance.getToken();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginDataModel loginDataModel;
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      loginDataModel = LoginDataModel.fromJson(userMap);
      this.loginDataModel = loginDataModel;
    }
  }

  Future<void> logoutUser(context) async {
    Either<Failure, StatusResponse> response =
        await logoutUseCase([loginDataModel!.data!.accessToken!, token!]);

    response.fold(
      (l) => logout = translateText(AppStrings.errorMessage, context),
      (r) {
        if (r.message == 'log out successfully') {
          logout = 'SuccessFully';
        } else {
          logout = translateText(AppStrings.errorMessage, context);
        }
      },
    );
  }

  Future<void> getSavedLanguage() async {
    final response = await getSavedLanguageUseCase.call(NoParams());
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLanguageCode = value!;
      emit(ChangeLocaleState(locale: Locale(currentLanguageCode)));
    });
  }

  Future<void> _changeLanguage(String languageCode) async {
    final response = await changeLanguageUseCase.call(languageCode);
    response.fold((failure) => debugPrint(AppStrings.cacheFailure), (value) {
      currentLanguageCode = languageCode;
      emit(ChangeLocaleState(locale: Locale(currentLanguageCode)));
    });
  }

  void toEnglish() => _changeLanguage(AppStrings.englishCode);

  void toArabic() => _changeLanguage(AppStrings.arabicCode);

  void toKurdish() => _changeLanguage(AppStrings.kurdishCode);
}
