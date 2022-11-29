import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/map_failure_message.dart';
import '../../../login/data/models/login_data_model.dart';
import '../../domain/entities/categories_domain_model.dart';
import '../../domain/entities/device_token_model.dart';
import '../../domain/entities/new_popular_domain_model.dart';
import '../../domain/entities/slider_domain_model.dart';
import '../../domain/use_cases/get_add_and_popular_items_use_case.dart';
import '../../domain/use_cases/get_categories_use_case.dart';
import '../../domain/use_cases/get_slider_use_case.dart';
import '../../domain/use_cases/send_device_token_use_case.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit(
    this.sendDeviceTokenUseCase, {
    required this.getNewAndPopularItemsUseCase,
    required this.getCategoriesUseCase,
    required this.getSliderUseCase,
  }) : super(HomePageInitial()) {
    getAllDataOfHomePage();
  }

  final GetSliderUseCase getSliderUseCase;
  final GetCategoriesUseCase getCategoriesUseCase;
  final GetNewAndPopularItemsUseCase getNewAndPopularItemsUseCase;
  final SendDeviceTokenUseCase sendDeviceTokenUseCase;

  HomeSlider? slider;
  Categories? categories;
  NewPopularItems? newPopularItems;

  LoginDataModel? loginDataModel;

  Future<void> getAllDataOfHomePage() async {
    getStoreUser().whenComplete(
      () => getSliderData().whenComplete(
        () => getCategoriesData().whenComplete(
          () => getNewPopularItemsData().whenComplete(
            () => emit(
              HomePageGetAllDataFinish(
                slider!,
                categories!,
                newPopularItems!,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String softwareType = '';
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      LoginDataModel loginDataModel = LoginDataModel.fromJson(userMap);
      if (loginDataModel.message != null) {
        String? token = await FirebaseMessaging.instance.getToken();
        if (Platform.isAndroid) {
          softwareType = 'android';
          if (loginDataModel.message!.isNotEmpty) {
            sendDeviceTokenUseCase(
              DeviceTokenModel(
                deviceToken: token,
                softwareType: softwareType,
                userToken: loginDataModel.data!.accessToken,
              ),
            );
          } else {
            print('----------------- no user ---------------------');
          }
        } else if (Platform.isIOS) {
          softwareType = 'ios';
          if (loginDataModel.message!.isNotEmpty) {
            sendDeviceTokenUseCase(
              DeviceTokenModel(
                deviceToken: token,
                softwareType: softwareType,
                userToken: loginDataModel.data!.accessToken,
              ),
            );
          } else {
            print('----------------- no user ---------------------');
          }
        }
      }
      this.loginDataModel = loginDataModel;
    }
  }

  Future<void> getSliderData() async {
    emit(HomePageLoading());
    Either<Failure, HomeSlider> response = await getSliderUseCase(NoParams());

    emit(
      response.fold(
        (failure) => HomePageError(
            message: MapFailureMessage.mapFailureToMessage(failure)),
        (slider) {
          this.slider = slider;
          return HomePageSliderLoaded(slider: slider);
        },
      ),
    );
  }

  Future<void> getCategoriesData() async {
    emit(HomePageLoading());
    Either<Failure, Categories> response =
        await getCategoriesUseCase(NoParams());
    emit(
      response.fold(
        (failure) => HomePageError(
            message: MapFailureMessage.mapFailureToMessage(failure)),
        (categories) {
          this.categories = categories;
          return HomePageCategoriesLoaded(categories: categories);
        },
      ),
    );
  }

  Future<void> getNewPopularItemsData() async {
    emit(HomePageLoading());
    Either<Failure, NewPopularItems> response =
        await getNewAndPopularItemsUseCase(loginDataModel == null
            ? 'null'
            : loginDataModel!.data!.user!.id.toString());
    emit(
      response.fold(
        (failure) => HomePageError(
            message: MapFailureMessage.mapFailureToMessage(failure)),
        (newPopularItems) {
          this.newPopularItems = newPopularItems;
          return HomePageNewsPopularItemsLoaded(
              newPopularItems: newPopularItems);
        },
      ),
    );
  }
}
