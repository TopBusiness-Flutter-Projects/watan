import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:elwatn/features/home_page/domain/entities/main_item_domain_model.dart';
import 'package:elwatn/features/show_more_posts/domain/use_cases/show_more_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/utils/map_failure_message.dart';
import '../../../login/data/models/login_data_model.dart';
import '../../domain/entities/show_more_domain_model.dart';
import '../../domain/use_cases/pagination_use_case.dart';

part 'show_more_state.dart';

class ShowMoreCubit extends Cubit<ShowMoreState> {
  ShowMoreCubit(
      {required this.getPaginationUseCase, required this.getShowMoreUseCase})
      : super(ShowMoreInitial());
  final GetShowMoreUseCase getShowMoreUseCase;
  final GetPaginationUseCase getPaginationUseCase;

  bool isLoadingVertical = false;
  late ShowMore showMore;
  List<MainItem> mainItemsList = [];
  List<MainItem> newMainItemsList = [];
  LoginDataModel? loginDataModel;

  Future<void> getStoreUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    LoginDataModel loginDataModel;
    if (prefs.getString('user') != null) {
      Map<String, dynamic> userMap = jsonDecode(prefs.getString('user')!);
      loginDataModel = LoginDataModel.fromJson(userMap);
      this.loginDataModel = loginDataModel;
    } else {
      this.loginDataModel = null;
    }
  }

  Future<void> getShowMoreData({required String pram}) async {
    emit(ShowMoreLoading());
    Either<Failure, ShowMore> response;
    if (loginDataModel != null) {
      response = await getShowMoreUseCase(
          [pram, loginDataModel!.data!.user!.id.toString()]);
      emit(
        response.fold(
          (failure) => ShowMoreLoadedError(
              message: MapFailureMessage.mapFailureToMessage(failure)),
          (showMore) {
            this.showMore = showMore;
            mainItemsList = showMore.data!.mainItem!;
            return ShowMoreLoaded(showMore: showMore);
          },
        ),
      );
    } else {
      getStoreUser().then((value) async {
        response = await getShowMoreUseCase([
          pram,
          '${loginDataModel == null ? 'null' : loginDataModel!.data!.user!.id.toString()}'
        ]);
        emit(
          response.fold(
            (failure) => ShowMoreLoadedError(
                message: MapFailureMessage.mapFailureToMessage(failure)),
            (showMore) {
              this.showMore = showMore;
              mainItemsList = showMore.data!.mainItem!;
              return ShowMoreLoaded(showMore: showMore);
            },
          ),
        );
      });
    }
  }

  Future<void> getPaginationData(
      {required String pram, required String link}) async {
    Either<Failure, ShowMore> response;
    if (loginDataModel != null) {
      response = await getPaginationUseCase(
          [link, pram, loginDataModel!.data!.user!.id.toString()]);
      emit(
        response.fold(
          (failure) => ShowMoreLoadedError(
              message: MapFailureMessage.mapFailureToMessage(failure)),
          (showMore) {
            this.showMore = showMore;
            newMainItemsList = showMore.data!.mainItem!;
            loadMoreVertical();
            return ShowMoreLoaded(showMore: showMore);
          },
        ),
      );
    } else {
      getStoreUser().then((value) async {
        response = await getPaginationUseCase(
            [link, pram, '${ loginDataModel==null?'null':loginDataModel!.data!.user!.id.toString()}']);
        emit(
          response.fold(
            (failure) => ShowMoreLoadedError(
                message: MapFailureMessage.mapFailureToMessage(failure)),
            (showMore) {
              this.showMore = showMore;
              newMainItemsList = showMore.data!.mainItem!;
              loadMoreVertical();
              return ShowMoreLoaded(showMore: showMore);
            },
          ),
        );
      });
    }
  }

  loadMoreVertical() async {
    changeBool(isLoadingVertical);
    mainItemsList = List.from(mainItemsList)..addAll(newMainItemsList);
    changeBool(isLoadingVertical);
  }

  changeBool(bool theChangeBoolean) {
    isLoadingVertical = !theChangeBoolean;
    emit(ChangeBoolean());
  }
}
