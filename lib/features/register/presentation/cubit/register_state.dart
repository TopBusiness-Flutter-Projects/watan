part of 'register_cubit.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterLoaded extends RegisterState {
  final RegistrationDataModel loginModel;

  RegisterLoaded(this.loginModel);

  @override
  List<Object?> get props => [loginModel];
}

class RegisterFailure extends RegisterState {
  final String message;

  RegisterFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterUserChanged extends RegisterState {}

class RegisterUserChangedDone extends RegisterState {}

class RegisterValidator extends RegisterState {
  final int code;

  RegisterValidator(this.code);
}

// ignore: must_be_immutable
class UserPhotoPicked extends RegisterState {
  final File image;

  UserPhotoPicked(this.image);
  @override
  List<Object> get props => [image];
}

class UpdateProfileLoading extends RegisterState {}

class UpdateProfileLoaded extends RegisterState {
  final LoginModel statusResponse;

  UpdateProfileLoaded(this.statusResponse);

  @override
  List<Object?> get props => [statusResponse];
}

class UpdateProfileFailure extends RegisterState {
  final String message;

  UpdateProfileFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class UpdateStoreDataSuccessfully extends RegisterState {}

class UpdateStoreDataFailure extends RegisterState {}

class SendCodeLoading extends RegisterState {}

class SendCodeFailure extends RegisterState {}

class SendCodeSuccessfully extends RegisterState {}

class SendCodeInvalidEmail extends RegisterState {}

class CheckCodeLoading extends RegisterState {}

class CheckCodeFailure extends RegisterState {}

class CheckCodeSuccessfully extends RegisterState {}

class CheckCodeError extends RegisterState {}

class CheckCodeLoaded extends RegisterState {}

class CheckCodeLoading2 extends RegisterState {}

class CheckCodeInvalidCode extends RegisterState {}

class ResetPasswordLoading extends RegisterState {}

class ResetPasswordFailure extends RegisterState {}

class ResetPasswordSuccessfully extends RegisterState {}

class ResetPasswordInvalidCode extends RegisterState {}

class OnTimerChanged extends RegisterState {
  String time;

  OnTimerChanged(this.time);
}

class OnTimerChangedAgain extends RegisterState {}

class OnSmsCodeSent extends RegisterState {
  String smsCode;

  OnSmsCodeSent(this.smsCode);
}

class Reset2PasswordLoading extends RegisterState {}

class Reset2PasswordFailure extends RegisterState {}

class Reset2PasswordSuccessfully extends RegisterState {}
