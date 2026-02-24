import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/auth/auth_bloc.dart';
import '../../business_logic/auth/auth_event.dart';
import '../../business_logic/auth/auth_state.dart';
import 'otp_screen.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {

        // ✅ When OTP is sent → Go to OTP screen
        if (state is OtpSentState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => OtpScreen(
                verificationId: state.verificationId,
              ),
            ),
          );
        }

        // ✅ If auto verification happens → Go directly to Home
        if (state is AuthSuccess) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
          );
        }

        // ✅ If error happens
        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },

      child: Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              const SizedBox(height: 30),

              TextField(
                controller: phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: "Enter Phone Number",
                  hintText: "+1234567890 (with country code)",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                    SendOtpEvent(
                      phoneController.text.trim(),
                    ),
                  );
                },
                child: const Text("Send OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}