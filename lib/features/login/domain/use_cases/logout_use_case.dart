import 'package:dartz/dartz.dart';
import 'package:elwatn/core/models/response_message.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/base_login_repositories.dart';

class LogoutUseCase implements UseCase<StatusResponse, List<String>> {
  final BaseLoginRepositories baseLoginRepositories;

  const LogoutUseCase({required this.baseLoginRepositories});

  @override
  Future<Either<Failure, StatusResponse>> call(List<String> param) =>
      baseLoginRepositories.logout(param[0], param[1]);
}
