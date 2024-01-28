import 'package:dartz/dartz.dart';

import 'package:elwatn/core/error/failures.dart';
import 'package:elwatn/core/models/response_message.dart';
import 'package:elwatn/features/login/domain/entities/login_domain_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/base_registration_repositories.dart';
import '../data_sources/base_register_data_source.dart';
import '../models/register_data_model.dart';
import '../models/verifywhats.dart';
import '../models/whatsmodel.dart';

class RegisterRepositories implements BaseRegistrationRepositories {
  final BaseNetworkInfo networkInfo;
  final BaseRegistrationDataSource baseRegistrationDataSource;

  RegisterRepositories(this.networkInfo, this.baseRegistrationDataSource);

  @override
  Future<Either<Failure, RegistrationDataModel>> postRegister(
      RegistrationUserModel user) async {
    try {
      final registerData =
          await baseRegistrationDataSource.postRegisterData(user);
      return Right(registerData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, LoginModel>> updateProfile(
      RegistrationUserModel user) async {
    try {
      final updateData =
          await baseRegistrationDataSource.updateProfileData(user);
      return Right(updateData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, LoginModel>> updateStoreProfile(String token) async {
    try {
      final loginModel =
          await baseRegistrationDataSource.updateStoreProfileData(token);
      return Right(loginModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> sendCodeToEmail(String email) async {
    try {
      final response = await baseRegistrationDataSource.sendCodeToEmail(email);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> checkCode(
      {required String code}) async {
    try {
      final response = await baseRegistrationDataSource.checkCode(code: code);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> resetPassword(
      List<String> passwords) async {
    try {
      final response =
          await baseRegistrationDataSource.resetPassword(passwords);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WhatsAppResponseModel>> whatsAppVerify(
      {required String phoneNumber}) async {
    try {
      final response = await baseRegistrationDataSource.whatsAppVerify(
          phoneNumber: phoneNumber);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, WhatsAppResponseCodeModel>> verifyWhatsApp(
      {required String code}) async {
    try {
      final response =
          await baseRegistrationDataSource.verifyWhatsApp(code: code);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
