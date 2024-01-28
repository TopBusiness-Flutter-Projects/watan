import 'package:dartz/dartz.dart';

import 'package:elwatn/core/error/failures.dart';

import '../../../../core/usecases/usecase.dart';
import '../../data/models/verifywhats.dart';
import '../repositories/base_registration_repositories.dart';

class VerifyWhatsAppCodeUseCase
    implements UseCase<WhatsAppResponseCodeModel, String> {
  final BaseRegistrationRepositories baseRegistrationRepositories;
  VerifyWhatsAppCodeUseCase(this.baseRegistrationRepositories);

  @override
  Future<Either<Failure, WhatsAppResponseCodeModel>> call(String code) =>
      baseRegistrationRepositories.verifyWhatsApp(code: code);
}
