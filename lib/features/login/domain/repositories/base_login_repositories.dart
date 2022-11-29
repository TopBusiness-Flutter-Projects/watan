import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/response_message.dart';
import '../../data/models/login_data_model.dart';
import '../entities/login_domain_model.dart';


abstract class BaseLoginRepositories{
  Future<Either<Failure, LoginDataModel>> postLogin(String email,String password);
  Future<Either<Failure, StatusResponse>> logout(String userToken,String deviceToken);
}