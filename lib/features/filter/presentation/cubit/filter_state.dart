part of 'filter_cubit.dart';

abstract class FilterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FilterInitial extends FilterState {}

class FilterCitiesLoading extends FilterState {}

class FilterCitiesLocationLoading extends FilterState {}

class FilterAmenitiesLoading extends FilterState {}

class FilterAgentsLoading extends FilterState {}

class FilterResponseLoading extends FilterState {}

class FilterCitiesLoaded extends FilterState {
  final CitiesFilterModel citiesFilterModel;

  FilterCitiesLoaded(this.citiesFilterModel);
  @override
  List<Object?> get props => [citiesFilterModel];
}

class FilterCitiesLocationLoaded extends FilterState {
  final CitiesLocationsModel citiesLocationsModel;

  FilterCitiesLocationLoaded(this.citiesLocationsModel);
  @override
  List<Object?> get props => [citiesLocationsModel];
}

class FilterAmenitiesLoaded extends FilterState {
  final AmenitiesFilterModel amenitiesFilterModel;

  FilterAmenitiesLoaded(this.amenitiesFilterModel);
  @override
  List<Object?> get props => [amenitiesFilterModel];
}

class FilterAgentsLoaded extends FilterState {
  final FilterAgentListModel filterAgentListModel;

  FilterAgentsLoaded(this.filterAgentListModel);
  @override
  List<Object?> get props => [filterAgentListModel];
}

class FilterResponseLoaded extends FilterState {
  final FilterResponse filterResponse;

  FilterResponseLoaded(this.filterResponse);
  @override
  List<Object?> get props => [filterResponse];
}

class FilterCitiesError extends FilterState {
  final String message;

  FilterCitiesError(this.message);
  @override
  List<Object?> get props => [message];
}

class FilterCitiesLocationError extends FilterState {
  final String message;

  FilterCitiesLocationError(this.message);
  @override
  List<Object?> get props => [message];
}

class FilterAmenitiesError extends FilterState {
  final String message;

  FilterAmenitiesError(this.message);
  @override
  List<Object?> get props => [message];
}

class FilterAgentsError extends FilterState {
  final String message;

  FilterAgentsError(this.message);
  @override
  List<Object?> get props => [message];
}

class FilterResponseError extends FilterState {
  final String message;

  FilterResponseError(this.message);
  @override
  List<Object?> get props => [message];
}

class PageChanged extends FilterState {}

class FilterGetAddDataLoading extends FilterState {}

class FilterGetAddDataLoaded extends FilterState {}
