part of 'add_project_cubit.dart';

abstract class AddProjectState extends Equatable{
  @override
  List<Object?> get props => [];
}

class AddProjectInitial extends AddProjectState {}


class AddProjectCitiesLoading extends AddProjectState {}
class AddProjectCitiesLocationLoading extends AddProjectState {}
class AddProjectAmenitiesLoading extends AddProjectState {}
class AddProjectPostLoading extends AddProjectState {}

class AddProjectCitiesLoaded extends AddProjectState {
  final CitiesFilterModel citiesFilterModel;

  AddProjectCitiesLoaded(this.citiesFilterModel);
  @override
  List<Object?> get props => [citiesFilterModel];
}
class AddProjectCitiesLocationLoaded extends AddProjectState {
  final CitiesLocationsModel citiesLocationsModel;

  AddProjectCitiesLocationLoaded(this.citiesLocationsModel);
  @override
  List<Object?> get props => [citiesLocationsModel];
}
class AddProjectAmenitiesLoaded extends AddProjectState {
  final AmenitiesFilterModel amenitiesFilterModel;

  AddProjectAmenitiesLoaded(this.amenitiesFilterModel);
  @override
  List<Object?> get props => [amenitiesFilterModel];
}
class AddProjectPostLoaded extends AddProjectState {
  final StatusResponse statusResponse;

  AddProjectPostLoaded(this.statusResponse);
  @override
  List<Object?> get props => [statusResponse];
}

class AddProjectCitiesError extends AddProjectState {
  final String message;

  AddProjectCitiesError(this.message);
  @override
  List<Object?> get props => [message];
}
class AddProjectCitiesLocationError extends AddProjectState {
  final String message;

  AddProjectCitiesLocationError(this.message);
  @override
  List<Object?> get props => [message];
}
class AddProjectAmenitiesError extends AddProjectState {
  final String message;

  AddProjectAmenitiesError(this.message);
  @override
  List<Object?> get props => [message];
}
class AddProjectPostError extends AddProjectState {
  final String message;

  AddProjectPostError(this.message);
  @override
  List<Object?> get props => [message];
}
class AddProjectPostErrorResponse extends AddProjectState {
  final StatusResponse statusResponse;

  AddProjectPostErrorResponse(this.statusResponse);
  @override
  List<Object?> get props => [statusResponse];
}

class ProjectAmenitiesSelected extends AddProjectState {}
class ProjectNewImagePicked extends AddProjectState {}

class ProjectChangeState extends AddProjectState {}
class UpdateAdsPostLoaded extends AddProjectState {
  final StatusResponse statusResponse;

  UpdateAdsPostLoaded(this.statusResponse);

  @override
  List<Object?> get props => [statusResponse];
}
class UpdateAdsPostLoading extends AddProjectState {}

class UpdateAdsPostError extends AddProjectState {
  final String message;

  UpdateAdsPostError(this.message);

  @override
  List<Object?> get props => [message];
}

class UpdateAdsPostErrorResponse extends AddProjectState {
  final StatusResponse statusResponse;

  UpdateAdsPostErrorResponse(this.statusResponse);

  @override
  List<Object?> get props => [statusResponse];
}


class ChangePaymentState extends AddProjectState {}
class ChangeUnitPlanState extends AddProjectState {}
class ChangeLocationState extends AddProjectState {}

