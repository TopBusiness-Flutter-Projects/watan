import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/map_failure_message.dart';
import '../../../home_page/data/models/main_item_data_model.dart';
import '../../../home_page/data/models/main_project_item_data_model.dart';
import '../../../login/data/models/login_data_model.dart';
import '../../data/models/my_ads_data_model.dart';
import '../../domain/use_cases/change_status_use_case.dart';
import '../../domain/use_cases/delete_ads_use_case.dart';
import '../../domain/use_cases/my_ads_use_case.dart';

part 'my_ads_state.dart';

class MyAdsCubit extends Cubit<MyAdsState> {
  MyAdsCubit(
    this.getMyAdsUseCase,
    this.deleteMyAdsUseCase,
    this.changeStatusMyAdsUseCase,
  ) : super(MyAdsInitial());

  List<MainItemModel> forSaleList = [];
  List<MainItemModel> forRentList = [];
  List<MainProjectItemModel> forSaleProjectList = [];
  late LoginDataModel loginDataModel;

  bool isActive = false;

  final GetMyAdsUseCase getMyAdsUseCase;
  final DeleteMyAdsUseCase deleteMyAdsUseCase;
  final ChangeStatusMyAdsUseCase changeStatusMyAdsUseCase;

  setStateWidgets(){
    isActive=true;
    emit(MyAdsSetStateWidget());
  }

  Future<LoginDataModel> getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginDataModel loginDataModel;
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      loginDataModel = LoginDataModel.fromJson(userMap);
      this.loginDataModel = loginDataModel;
    } else {
      loginDataModel = LoginDataModel.fromJson({});
    }
    return loginDataModel;
  }

  getMyProfileAds(String token, String kind, String userType) async {
    emit(MyAdsLoading());
    final response = await getMyAdsUseCase([token, kind, userType]);
    emit(
      response.fold(
        (failure) => MyAdsError(
          MapFailureMessage.mapFailureToMessage(failure),
        ),
        (profileAdsModel) {
          if (userType != '3') {
            forSaleList = profileAdsModel.data!.forSale!;
            forRentList = profileAdsModel.data!.forRent!;
          } else {
            forSaleProjectList = profileAdsModel.data!.forSaleProject!;
          }
          isActive = false;
          return MyAdsLoaded(profileAdsModel);
        },
      ),
    );
  }

  deleteMyProfileAds(String id, String kind, String userType) async {
    emit(MyAdsLoading());
    final response = await deleteMyAdsUseCase(
        [id, loginDataModel.data!.accessToken!, userType]);

    response.fold(
      (failure) =>
          emit(MyAdsError(MapFailureMessage.mapFailureToMessage(failure))),
      (response) {
        if (response.code == 200) {
          emit(MyAdsDeletedSuccessfully());
          Future.delayed(const Duration(milliseconds: 700), () {
            getMyProfileAds(loginDataModel.data!.accessToken!, kind, userType);
          });
        }
      },
    );
  }

  changeStatusMyProfileAds(String id, String kind, String userType) async {
    emit(MyAdsLoading());
    final response =
        await changeStatusMyAdsUseCase([id, loginDataModel.data!.accessToken!]);

    response.fold(
      (failure) =>
          emit(MyAdsError(MapFailureMessage.mapFailureToMessage(failure))),
      (response) {
        if (response.code == 200) {
          emit(MyAdsChangeStatusSuccessfully());
          Future.delayed(const Duration(milliseconds: 700), () {
            getMyProfileAds(loginDataModel.data!.accessToken!, kind, userType);
          });
        }
      },
    );
  }
}
