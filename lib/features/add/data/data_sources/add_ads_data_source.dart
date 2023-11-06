import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:elwatn/core/models/response_message.dart';

import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../domain/entities/add_ads_model.dart';

abstract class BaseAddAdsDataSource {
  Future<StatusResponse> addAds(AddAdsModel addAdsModel);

  Future<StatusResponse> updateAds(AddAdsModel addAdsModel);

  Future<StatusResponse> addProject(AddAdsModel addAdsModel);
}

class AddAdsDataSource extends BaseAddAdsDataSource {
  final BaseApiConsumer apiConsumer;

  AddAdsDataSource(this.apiConsumer);

  @override
  Future<StatusResponse> addAds(AddAdsModel addAdsModel) async {
    print(addAdsModel.token);
    print('......................................');
    final response = await apiConsumer.newPost(
      EndPoints.addAdsUrl,
      formDataIsEnabled: true,
      body: addAdsModel.videos!.isEmpty
          ? await addAdsModel.toJsonWithoutVideo()
          : await addAdsModel.toJsonWithVideo(),
      options: Options(
        headers: {
          "Authorization": addAdsModel.token,
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    return StatusResponse.fromJson(jsonDecode(response.data));
  }

  @override
  Future<StatusResponse> addProject(AddAdsModel addAdsModel) async {
    final response = await apiConsumer.newPost(
      EndPoints.addProjectUrl,
      formDataIsEnabled: true,
      body: addAdsModel.videos!.isEmpty
          ? await addAdsModel.toJsonProjectWithoutVideo()
          : await addAdsModel.toJsonProjectWithVideo(),
      options: Options(
        headers: {
          "Authorization": addAdsModel.token,
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    return StatusResponse.fromJson(jsonDecode(response.data));
  }

  @override
  Future<StatusResponse> updateAds(AddAdsModel addAdsModel) async {
    final response = await apiConsumer.newPost(
      addAdsModel.kindOfPost != 'project'
          ? EndPoints.updateAdsUrl + addAdsModel.id.toString()
          : EndPoints.updateProjectUrl + addAdsModel.id.toString(),
      formDataIsEnabled: true,
      body: addAdsModel.kindOfPost != 'project'
          ? addAdsModel.videos!.isEmpty
              ? await addAdsModel.toJsonWithoutVideoUpdate()
              : await addAdsModel.toJsonWithVideoUpdate()
          : addAdsModel.videos!.isEmpty
              ? await addAdsModel.toJsonProjectWithoutVideoUpdate()
              : await addAdsModel.toJsonProjectWithVideoUpdate(),
      options: Options(
        headers: {
          "Authorization": addAdsModel.token,
        },
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
      ),
    );
    return StatusResponse.fromJson(jsonDecode(response.data));
  }
}
