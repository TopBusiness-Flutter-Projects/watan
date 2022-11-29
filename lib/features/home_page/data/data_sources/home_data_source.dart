import 'package:dio/dio.dart';
import 'package:elwatn/core/models/response_message.dart';

import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../domain/entities/categories_domain_model.dart';
import '../../domain/entities/device_token_model.dart';
import '../../domain/entities/new_popular_domain_model.dart';
import '../../domain/entities/slider_domain_model.dart';
import '../models/categories_data_model.dart';
import '../models/new_popular_data_model.dart';
import '../models/slider_data_model.dart';

abstract class BaseHomePageDataSource {
  Future<HomeSlider> getSliderImages();

  Future<Categories> getCategories();

  Future<NewPopularItems> getNewPopularItems(String userId);

  Future<StatusResponse> sendDeviceToken(DeviceTokenModel deviceTokenModel);
}

class HomePageDataSource implements BaseHomePageDataSource {
  final BaseApiConsumer apiConsumer;

  const HomePageDataSource({required this.apiConsumer});

  @override
  Future<HomeSlider> getSliderImages() async {
    final response = await apiConsumer.get(EndPoints.sliderUrl);
    return SliderModel.fromJson(response);
  }

  @override
  Future<Categories> getCategories() async {
    final response = await apiConsumer.get(EndPoints.categoriesUrl);
    return CategoriesModel.fromJson(response);
  }

  @override
  Future<NewPopularItems> getNewPopularItems(String userId) async {
    final response = await apiConsumer
        .get(EndPoints.newPopularUrl, queryParameters: {'user_id': userId});
    return NewPopularItemsModel.fromJson(response);
  }

  @override
  Future<StatusResponse> sendDeviceToken(
      DeviceTokenModel deviceTokenModel) async {
    final response = await apiConsumer.post(EndPoints.insertDeviceTokenUrl,
        body: deviceTokenModel.toJson(),
        options: Options(headers: {
          "Authorization": deviceTokenModel.userToken,
        }));
    return StatusResponse.fromJson(response);
  }
}
