import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../core/api/base_api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../domain/entities/open_room_model.dart';
import '../models/MyRooms.dart';
import '../models/get_one_message_model.dart';
import '../models/send_message_model.dart';

abstract class BaseChatDataSource {
  Future<ChatModel> getMyRooms(String token);

  Future<ChatModel> openRoom(OpenRoom openRoom);

  Future<ChatModel> getOneRoom(String roomId, String token);

  Future<GetOneMessage> sendMessage(SendMessage sendMessage);
}

class ChatDataSource extends BaseChatDataSource {
  final BaseApiConsumer baseApiConsumer;

  ChatDataSource(this.baseApiConsumer);

  @override
  Future<ChatModel> getMyRooms(String token) async {
    final response = await baseApiConsumer.get(EndPoints.myRoomsUrl,
        options: Options(headers: {"Authorization": token}));
    return ChatModel.chatModelMyRoomsFromJson(response);
  }

  @override
  Future<ChatModel> getOneRoom(String roomId, String token) async {
    final response = await baseApiConsumer.get(EndPoints.oneRoomUrl,
        options: Options(
          headers: {"Authorization": token},
        ),
        queryParameters: {"room_id": roomId});
    return ChatModel.chatModelOneRoomFromJson(response);
  }

  @override
  Future<GetOneMessage> sendMessage(SendMessage sendMessage) async {
    print(sendMessage.file);
    print(sendMessage.type);
    Response response = await baseApiConsumer.newPost(
      formDataIsEnabled: true,
      EndPoints.sendMessageUrl,
      body: sendMessage.type != "file"
          ? sendMessage.sendMessageWithoutPhotoToJson()
          : await sendMessage.sendMessageWithPhotoToJson(),
      options: Options(
        headers: {
          "Authorization": sendMessage.token,
          "Connection": 'keep-alive',
        },
      ),
    );
    return GetOneMessage.fromJson(jsonDecode(response.data));
  }

  @override
  Future<ChatModel> openRoom(OpenRoom openRoom) async {
    final response = await baseApiConsumer.post(
      EndPoints.openRoomUrl,
      body: openRoom.type == 'post'
          ? openRoom.postToJson()
          : openRoom.projectToJson(),
      options: Options(
        headers: {"Authorization": openRoom.token},
      ),
    );
    return ChatModel.chatModelOpenRoomFromJson(response);
  }
}
