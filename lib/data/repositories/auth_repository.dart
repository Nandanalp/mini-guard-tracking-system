import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer' as developer;

class AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> sendOtp({
    required String phoneNumber,
    required Function(String verificationId) codeSent,
    required Function(String error) onError,
  }) async {
    // Validate and format phone number
    String formattedPhone = phoneNumber.trim();
    if (!formattedPhone.startsWith('+')) {
      formattedPhone = '+${formattedPhone.replaceAll(RegExp(r'\D'), '')}';
    }

    developer.log('📱 Sending OTP to: $formattedPhone');

    try {
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: formattedPhone,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (PhoneAuthCredential credential) async {
          developer.log('✅ Auto-verification completed');
          try {
            await _firebaseAuth.signInWithCredential(credential);
            developer.log('✅ Auto sign-in successful');
          } catch (e) {
            developer.log('❌ Auto sign-in failed: $e');
            onError('Auto sign-in failed: $e');
          }
        },

        verificationFailed: (FirebaseAuthException e) {
          developer.log('❌ Verification failed: ${e.message}');
          onError(e.message ?? "Verification failed");
        },

        codeSent: (String verificationId, int? resendToken) {
          developer.log('✅ OTP sent successfully! Verification ID: $verificationId');
          codeSent(verificationId);
        },

        codeAutoRetrievalTimeout: (String verificationId) {
          developer.log('⏱️ Auto-retrieval timeout: $verificationId');
        },
        
        // For Android emulator testing - disable reCAPTCHA
        forceResendingToken: null,
      );
    } catch (e) {
      developer.log('❌ Exception during sendOtp: $e');
      onError('Exception: $e');
    }
  }

  Future<void> verifyOtp({
    required String verificationId,
    required String smsCode,
  }) async {

    PhoneAuthCredential credential =
        PhoneAuthProvider.credential(
          verificationId: verificationId,
          smsCode: smsCode,
        );

    await _firebaseAuth.signInWithCredential(credential);
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}