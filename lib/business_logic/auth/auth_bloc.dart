import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import 'dart:developer' as developer;

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {

    // SEND OTP
    on<SendOtpEvent>((event, emit) async {

      emit(AuthLoading());
      developer.log('🔄 SendOtpEvent triggered with phone: ${event.phoneNumber}');

      try {
        // Validate phone number format
        String phone = event.phoneNumber.trim();
        if (phone.isEmpty) {
          developer.log('❌ Phone number is empty');
          emit(AuthFailure("Please enter a phone number"));
          return;
        }

        developer.log('📱 Calling repository.sendOtp()');
        
        await repository.sendOtp(
          phoneNumber: phone,
          codeSent: (verificationId) {
            developer.log('📲 codeSent callback triggered with ID: $verificationId');
            emit(OtpSentState(verificationId));
          },
          onError: (error) {
            developer.log('❌ onError callback: $error');
            emit(AuthFailure("Failed to send OTP: $error"));
          },
        );
        
        developer.log('✅ sendOtp completed');
      } catch (e) {
        developer.log('❌ Exception in SendOtpEvent: $e');
        emit(AuthFailure("Error: ${e.toString()}"));
      }
    });

    // VERIFY OTP
    on<VerifyOtpEvent>((event, emit) async {

      emit(AuthLoading());

      try {
        await repository.verifyOtp(
          verificationId: event.verificationId,
          smsCode: event.smsCode,
        );

        emit(AuthSuccess());

      } catch (e) {
        emit(AuthFailure("Invalid OTP"));
      }
    });

    // SIGN OUT
    on<SignOutEvent>((event, emit) async {
      try {
        await repository.signOut();
        emit(AuthInitial());
      } catch (e) {
        emit(AuthFailure("Sign out failed"));
      }
    });
  }
}