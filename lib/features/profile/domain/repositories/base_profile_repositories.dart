import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/models/response_message.dart';
import '../../../home_page/data/models/main_item_data_model.dart';
import '../entities/agent_list_domain_model.dart';

abstract class BaseProfileRepositories {
  Future<Either<Failure, AgentProfileList>> getAgentList(String token);
  Future<Either<Failure, StatusResponse>> postNewAgent(AgentModel agentModel);
  Future<Either<Failure, StatusResponse>> editAgent(AgentModel agentModel);
  Future<Either<Failure, StatusResponse>> deleteAgent(AgentModel agentModel);

  Future<Either<Failure, StatusResponse>> deleteUserAccount(String token);
}
