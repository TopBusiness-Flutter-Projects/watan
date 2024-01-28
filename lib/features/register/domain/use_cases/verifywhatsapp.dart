import 'package:dartz/dartz.dart';

import 'package:elwatn/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/models/whatsmodel.dart';
import '../repositories/base_registration_repositories.dart';

class VerifyWhatsAppUseCase implements UseCase<WhatsAppResponseModel, String> {
  final BaseRegistrationRepositories baseRegistrationRepositories;
  VerifyWhatsAppUseCase(this.baseRegistrationRepositories);

  @override
  Future<Either<Failure, WhatsAppResponseModel>> call(String phoneNumber) =>
      baseRegistrationRepositories.whatsAppVerify(phoneNumber: phoneNumber);
}
