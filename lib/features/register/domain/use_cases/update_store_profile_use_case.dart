import 'package:dartz/dartz.dart';

import 'package:elwatn/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../login/domain/entities/login_domain_model.dart';
import '../repositories/base_registration_repositories.dart';

class UpdateStoreProfileUseCase implements UseCase<LoginModel, String> {
  final BaseRegistrationRepositories baseRegistrationRepositories;

  UpdateStoreProfileUseCase(this.baseRegistrationRepositories);

  @override
  Future<Either<Failure, LoginModel>> call(String params) =>
      baseRegistrationRepositories.updateStoreProfile(params);
}
