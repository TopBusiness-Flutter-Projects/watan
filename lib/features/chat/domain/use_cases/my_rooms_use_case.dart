import 'package:dartz/dartz.dart';
import 'package:elwatn/core/error/failures.dart';
import 'package:elwatn/core/usecases/usecase.dart';

import '../../data/models/MyRooms.dart';
import '../repositories/base_chat_repositories.dart';

class GetMyRoomsUseCase extends UseCase<ChatModel, String> {
  final BaseChatRepositories baseChatRepositories;

  GetMyRoomsUseCase(this.baseChatRepositories);
  @override
  Future<Either<Failure, ChatModel>> call(String params) =>
      baseChatRepositories.getMyRooms(params);
}
