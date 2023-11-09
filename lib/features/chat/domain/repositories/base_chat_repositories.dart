import 'package:dartz/dartz.dart';
import 'package:elwatn/core/error/failures.dart';

import '../../data/models/MyRooms.dart';
import '../../data/models/get_one_message_model.dart';
import '../../data/models/send_message_model.dart';
import '../entities/open_room_model.dart';

abstract class BaseChatRepositories {
  Future<Either<Failure, ChatModel>> getMyRooms(String token);
  Future<Either<Failure, ChatModel>> openRoom(OpenRoom openRoom);
  Future<Either<Failure, ChatModel>> getOneRoom(String roomId, String token);
  Future<Either<Failure, GetOneMessage>> sendMessage(SendMessage sendMessage);
}
