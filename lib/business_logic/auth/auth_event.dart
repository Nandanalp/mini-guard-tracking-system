import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;

  SendOtpEvent(this.phoneNumber);

  @override
  List<Object?> get props => [phoneNumber];
}

class VerifyOtpEvent extends AuthEvent {
  final String verificationId;
  final String smsCode;

  VerifyOtpEvent(this.verificationId, this.smsCode);

  @override
  List<Object?> get props => [verificationId, smsCode];
}

class CheckAuthStateEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}