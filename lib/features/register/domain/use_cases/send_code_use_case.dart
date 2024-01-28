import 'package:dartz/dartz.dart';

import 'package:elwatn/core/error/failures.dart';

import '../../../../core/models/response_message.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/base_registration_repositories.dart';

class SendCodeUseCase implements UseCase<StatusResponse, String> {
  final BaseRegistrationRepositories baseRegistrationRepositories;

  SendCodeUseCase(this.baseRegistrationRepositories);

  @override
  Future<Either<Failure, StatusResponse>> call(String params) =>
      baseRegistrationRepositories.sendCodeToEmail(params);
}
