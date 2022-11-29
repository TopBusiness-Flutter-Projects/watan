import 'package:dartz/dartz.dart';
import 'package:elwatn/core/models/response_message.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/device_token_model.dart';
import '../repositories/base_home_repositories.dart';

class SendDeviceTokenUseCase implements UseCase<StatusResponse, DeviceTokenModel> {
  final BaseHomeRepositories baseHomeRepositories;

  const SendDeviceTokenUseCase({required this.baseHomeRepositories});

  @override
  Future<Either<Failure, StatusResponse>> call(DeviceTokenModel params) =>
      baseHomeRepositories.sendDeviceToken(params);
}
