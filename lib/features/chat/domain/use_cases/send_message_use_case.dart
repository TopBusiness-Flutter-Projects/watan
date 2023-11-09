import 'package:dartz/dartz.dart';
import 'package:elwatn/core/error/failures.dart';
import 'package:elwatn/core/usecases/usecase.dart';
import '../../data/models/get_one_message_model.dart';
import '../../data/models/send_message_model.dart';
import '../repositories/base_chat_repositories.dart';

class SendMessageUseCase extends UseCase<GetOneMessage, SendMessage> {
  final BaseChatRepositories baseChatRepositories;

  SendMessageUseCase(this.baseChatRepositories);

  @override
  Future<Either<Failure, GetOneMessage>> call(SendMessage params) =>
      baseChatRepositories.sendMessage(params);
}
