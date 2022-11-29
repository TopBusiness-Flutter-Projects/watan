import 'package:dartz/dartz.dart';

import 'package:elwatn/core/error/failures.dart';
import 'package:elwatn/core/models/response_message.dart';

import 'package:elwatn/features/login/domain/entities/login_domain_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/repositories/base_login_repositories.dart';
import '../data_sources/login_data_source.dart';
import '../models/login_data_model.dart';

class LoginRepositories implements BaseLoginRepositories {
  final BaseNetworkInfo networkInfo;
  final BaseLoginDataSource baseLoginDataSource;

  LoginRepositories(this.networkInfo, this.baseLoginDataSource);

  @override
  Future<Either<Failure, LoginDataModel>> postLogin(
      String email, String password) async {
    try {
      final loginData =
          await baseLoginDataSource.postLoginData(email, password);
      return Right(loginData);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> logout(
      String userToken, String deviceToken) async {
    try {
      final response = await baseLoginDataSource.logout(userToken, deviceToken);
      return Right(response);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
