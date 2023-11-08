import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/models/response_message.dart';
import '../../../home_page/data/models/main_item_data_model.dart';
import '../../domain/entities/agent_list_domain_model.dart';
import '../models/agent_list_data_model.dart';

abstract class BaseProfileDataSource {
  Future<AgentProfileList> getAgentList(String token);
  Future<StatusResponse> postNewAgent(AgentModel agentModel);
  Future<StatusResponse> editAgent(AgentModel agentModel);
  Future<StatusResponse> deleteAgent(AgentModel agentModel);
  Future<StatusResponse> deleteUserAccount(String token);
}

class ProfileDataSource implements BaseProfileDataSource {
  final BaseApiConsumer apiConsumer;

  ProfileDataSource(this.apiConsumer);

  @override
  Future<AgentProfileList> getAgentList(String token) async {
    final response = await apiConsumer.get(EndPoints.agentProfileListUrl,
        options: Options(headers: {"Authorization": token}));
    return AgentProfileListModel.fromJson(response);
  }

  @override
  Future<StatusResponse> postNewAgent(AgentModel agentModel) async {
    Response response = await apiConsumer.newPost(
      EndPoints.agentProfileListUrl,
      body: await agentModel.postToJson(),
      formDataIsEnabled: true,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {"Authorization": agentModel.token},
      ),
    );
    return StatusResponse.fromJson(jsonDecode(response.data));
  }

  @override
  Future<StatusResponse> deleteAgent(AgentModel agentModel) async {
    final response = await apiConsumer.post(
        "${EndPoints.agentProfileListUrl}/${agentModel.id}",
        body: {"_method": "DELETE"},
        options: Options(headers: {"Authorization": agentModel.token}));
    return StatusResponse.fromJson(response);
  }

  @override
  Future<StatusResponse> editAgent(AgentModel agentModel) async {
    Response response = await apiConsumer.newPost(
      "${EndPoints.agentProfileListUrl}/${agentModel.id}",
      body: agentModel.image != null
          ? await agentModel.postToJson()
          : await agentModel.editToJson(),
      formDataIsEnabled: true,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {"Authorization": agentModel.token},
      ),
    );
    return StatusResponse.fromJson(jsonDecode(response.data));
  }

  @override
  Future<StatusResponse> deleteUserAccount(String token) async {
    final response = await apiConsumer.post(EndPoints.deleteAccountUrl,
        options: Options(headers: {"Authorization": token}));
    return StatusResponse.fromJson(response);
  }
}
