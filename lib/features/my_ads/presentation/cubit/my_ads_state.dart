part of 'my_ads_cubit.dart';

abstract class MyAdsState extends Equatable{
  @override
  List<Object?> get props => [];
}

class MyAdsInitial extends MyAdsState {}
class MyAdsSetStateWidget extends MyAdsState {}

class MyAdsDeletedSuccessfully extends MyAdsState {}
class MyAdsChangeStatusSuccessfully extends MyAdsState {}

class MyAdsLoading extends MyAdsState {}
class MyAdsLoaded extends MyAdsState {
  final ProfileAdsModel profileAdsModel;

  MyAdsLoaded(this.profileAdsModel);

  @override
  List<Object?> get props => [profileAdsModel];
}
class MyAdsError extends MyAdsState {
  final String message;
  MyAdsError(this.message);
  @override
  List<Object?> get props => [message];
}


