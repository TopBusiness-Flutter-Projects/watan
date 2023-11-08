import 'package:dartz/dartz.dart';

import 'package:elwatn/core/error/failures.dart';
import 'package:elwatn/features/home_page/data/models/main_item_data_model.dart';
import 'package:elwatn/features/profile/domain/entities/agent_list_domain_model.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/models/response_message.dart';
import '../../domain/repositories/base_profile_repositories.dart';
import '../data_sources/profile_data_sources.dart';

class ProfileRepositories implements BaseProfileRepositories {
  final BaseProfileDataSource baseProfileDataSource;

  ProfileRepositories(this.baseProfileDataSource);

  @override
  Future<Either<Failure, AgentProfileList>> getAgentList(String token) async {
    try {
      final agentList = await baseProfileDataSource.getAgentList(token);
      return Right(agentList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> postNewAgent(AgentModel agent) async {
    try {
      final agentModel = await baseProfileDataSource.postNewAgent(agent);
      return Right(agentModel);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> deleteAgent(
      AgentModel agentModel) async {
    try {
      final agent = await baseProfileDataSource.deleteAgent(agentModel);
      return Right(agent);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> editAgent(
      AgentModel agentModel) async {
    try {
      final agent = await baseProfileDataSource.editAgent(agentModel);
      return Right(agent);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, StatusResponse>> deleteUserAccount(
      String token) async {
    try {
      final deleteAccount =
          await baseProfileDataSource.deleteUserAccount(token);
      return Right(deleteAccount);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
