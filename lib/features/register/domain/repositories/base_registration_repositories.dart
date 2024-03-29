import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/response_message.dart';
import '../../../login/domain/entities/login_domain_model.dart';
import '../../data/models/register_data_model.dart';
import '../../data/models/verifywhats.dart';
import '../../data/models/whatsmodel.dart';

abstract class BaseRegistrationRepositories {
  Future<Either<Failure, RegistrationDataModel>> postRegister(
      RegistrationUserModel user);
  Future<Either<Failure, LoginModel>> updateProfile(RegistrationUserModel user);
  Future<Either<Failure, LoginModel>> updateStoreProfile(String token);
  Future<Either<Failure, StatusResponse>> sendCodeToEmail(String email);
  Future<Either<Failure, StatusResponse>> checkCode({required String code});
  Future<Either<Failure, StatusResponse>> resetPassword(List<String> passwords);
  Future<Either<Failure, WhatsAppResponseModel>> whatsAppVerify(
      {required String phoneNumber});
  Future<Either<Failure, WhatsAppResponseCodeModel>> verifyWhatsApp(
      {required String code});
}
