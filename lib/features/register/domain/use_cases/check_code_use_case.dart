import 'package:dartz/dartz.dart';
import 'package:elwatn/core/error/failures.dart';
import '../../../../core/models/response_message.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/base_registration_repositories.dart';

class CheckCodeUseCase implements UseCase<StatusResponse, String> {
  final BaseRegistrationRepositories baseRegistrationRepositories;

  CheckCodeUseCase(this.baseRegistrationRepositories);

  @override
  Future<Either<Failure, StatusResponse>> call(String params) =>
      baseRegistrationRepositories.checkCode(code: params);
}
