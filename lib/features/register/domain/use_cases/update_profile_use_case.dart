import 'package:dartz/dartz.dart';
import 'package:elwatn/core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../login/domain/entities/login_domain_model.dart';
import '../../data/models/register_data_model.dart';
import '../repositories/base_registration_repositories.dart';

class UpdateProfileUseCase
    implements UseCase<LoginModel, RegistrationUserModel> {
  final BaseRegistrationRepositories baseRegistrationRepositories;

  UpdateProfileUseCase(this.baseRegistrationRepositories);

  @override
  Future<Either<Failure, LoginModel>> call(RegistrationUserModel params) =>
      baseRegistrationRepositories.updateProfile(params);
}
