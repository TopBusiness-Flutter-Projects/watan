import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../domain/entities/filterModel.dart';
import '../../domain/entities/filter_response_domian_model.dart';
import '../models/agent_list_data_model.dart';
import '../models/amenities_data_model.dart';
import '../models/cities_data_model.dart';
import '../models/cities_location_data_model.dart';

abstract class BaseFilterDataSource {
  Future<CitiesFilterModel> getCitiesData();

  Future<CitiesLocationsModel> getCitiesLocationData(String id);

  Future<AmenitiesFilterModel> getAmenitiesData();

  Future<FilterAgentListModel> getAgentListData();

  Future<FilterResponse> getFilterData(FilterModel filterModel);
}

class FilterDataSource implements BaseFilterDataSource {
  final BaseApiConsumer apiConsumer;

  const FilterDataSource({required this.apiConsumer});

  @override
  Future<CitiesFilterModel> getCitiesData() async {
    final response = await apiConsumer.get(EndPoints.citiesUrl);
    return CitiesFilterModel.fromJson(response);
  }

  @override
  Future<CitiesLocationsModel> getCitiesLocationData(String id) async {
    final response =
        await apiConsumer.get("${EndPoints.citiesLocationUrl}/$id");
    return CitiesLocationsModel.fromJson(response);
  }

  @override
  Future<AmenitiesFilterModel> getAmenitiesData() async {
    final response = await apiConsumer.get(EndPoints.amenitiesUrl);
    return AmenitiesFilterModel.fromJson(response);
  }

  @override
  Future<FilterAgentListModel> getAgentListData() async {
    final response = await apiConsumer.get(EndPoints.filterAgentListUrl);
    return FilterAgentListModel.fromJson(response);
  }

  @override
  Future<FilterResponse> getFilterData(FilterModel filterModel) async {
    final response =
        await apiConsumer.post(EndPoints.filterUrl, body: filterModel.toJson());
    return FilterResponse.fromJson(response);
  }
}
