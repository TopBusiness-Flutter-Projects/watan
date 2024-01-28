import 'package:dartz/dartz.dart';
import 'package:elwatn/core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/models/register_data_model.dart';
import '../repositories/base_registration_repositories.dart';

class PostRegisterUserUseCase
    implements UseCase<RegistrationDataModel, RegistrationUserModel> {
  final BaseRegistrationRepositories baseRegistrationRepositories;

  PostRegisterUserUseCase(this.baseRegistrationRepositories);

  @override
  Future<Either<Failure, RegistrationDataModel>> call(
          RegistrationUserModel params) =>
      baseRegistrationRepositories.postRegister(params);
}
