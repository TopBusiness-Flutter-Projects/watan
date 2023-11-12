part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileUserDeletedLoading extends ProfileState {}

class ProfileUserDeletedSuccessfully extends ProfileState {}

class ProfileUserDeletedError extends ProfileState {}

//Agent States
class ProfileAgentLoading extends ProfileState {}

class ProfileAgentLoaded extends ProfileState {
  final AgentProfileList agentProfileList;

  ProfileAgentLoaded({required this.agentProfileList});

  @override
  List<Object> get props => [agentProfileList];
}

class ProfileAgentError extends ProfileState {
  final String message;

  ProfileAgentError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileAddedAgentLoading extends ProfileState {}

class ProfileAddedAgentLoaded extends ProfileState {
  final StatusResponse statusResponse;

  ProfileAddedAgentLoaded({required this.statusResponse});

  @override
  List<Object> get props => [statusResponse];
}

class ProfileAddedAgentError extends ProfileState {
  final String message;

  ProfileAddedAgentError({required this.message});

  @override
  List<Object> get props => [message];
}

class ProfileAgentDeletedSuccessfully extends ProfileState {}

class ProfileAgentValidator extends ProfileState {}

class ProfileEditAgentLoading extends ProfileState {}

class ProfileEditAgentLoaded extends ProfileState {
  final StatusResponse statusResponse;

  ProfileEditAgentLoaded({required this.statusResponse});

  @override
  List<Object> get props => [statusResponse];
}

class ProfileEditAgentError extends ProfileState {
  final String message;

  ProfileEditAgentError({required this.message});

  @override
  List<Object> get props => [message];
}
