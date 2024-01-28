import 'package:dartz/dartz.dart';

import 'package:elwatn/core/error/failures.dart';

import '../../../../core/models/response_message.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/base_registration_repositories.dart';

class ResetPasswordUseCase implements UseCase<StatusResponse, List<String>> {
  final BaseRegistrationRepositories baseRegistrationRepositories;

  ResetPasswordUseCase(this.baseRegistrationRepositories);

  @override
  Future<Either<Failure, StatusResponse>> call(List<String> params) =>
      baseRegistrationRepositories.resetPassword(params);
}
