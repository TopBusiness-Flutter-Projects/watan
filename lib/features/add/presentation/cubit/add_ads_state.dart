part of 'add_ads_cubit.dart';

abstract class AddAdsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddAdsInitial extends AddAdsState {}

class AddCitiesLoading extends AddAdsState {}

class AddCitiesLocationLoading extends AddAdsState {}

class AddAmenitiesLoading extends AddAdsState {}

class AddAdsPostLoading extends AddAdsState {}

class UpdateAdsPostLoading extends AddAdsState {}

class AddCitiesLoaded extends AddAdsState {
  final CitiesFilterModel citiesFilterModel;

  AddCitiesLoaded(this.citiesFilterModel);

  @override
  List<Object?> get props => [citiesFilterModel];
}

class AddCitiesLocationLoaded extends AddAdsState {
  final CitiesLocationsModel citiesLocationsModel;

  AddCitiesLocationLoaded(this.citiesLocationsModel);

  @override
  List<Object?> get props => [citiesLocationsModel];
}

class AddAmenitiesLoaded extends AddAdsState {
  final AmenitiesFilterModel amenitiesFilterModel;

  AddAmenitiesLoaded(this.amenitiesFilterModel);

  @override
  List<Object?> get props => [amenitiesFilterModel];
}

class AddAdsPostLoaded extends AddAdsState {
  final StatusResponse statusResponse;

  AddAdsPostLoaded(this.statusResponse);

  @override
  List<Object?> get props => [statusResponse];
}

class UpdateAdsPostLoaded extends AddAdsState {
  final StatusResponse statusResponse;

  UpdateAdsPostLoaded(this.statusResponse);

  @override
  List<Object?> get props => [statusResponse];
}

class AddCitiesError extends AddAdsState {
  final String message;

  AddCitiesError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddCitiesLocationError extends AddAdsState {
  final String message;

  AddCitiesLocationError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddAmenitiesError extends AddAdsState {
  final String message;

  AddAmenitiesError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddAdsPostError extends AddAdsState {
  final String message;

  AddAdsPostError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddAdsPostErrorResponse extends AddAdsState {
  final StatusResponse statusResponse;

  AddAdsPostErrorResponse(this.statusResponse);

  @override
  List<Object?> get props => [statusResponse];
}

class UpdateAdsPostError extends AddAdsState {
  final String message;

  UpdateAdsPostError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateAdsPostErrorResponse extends AddAdsState {
  final StatusResponse statusResponse;

  UpdateAdsPostErrorResponse(this.statusResponse);

  @override
  List<Object?> get props => [statusResponse];
}

class AmenitiesSelected extends AddAdsState {}

class NewImagePicked extends AddAdsState {}

class ChangeState extends AddAdsState {}
class ChangeLocationState extends AddAdsState {}
