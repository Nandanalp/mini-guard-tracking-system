import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../business_logic/auth/auth_bloc.dart';
import '../../business_logic/auth/auth_event.dart';
import '../../business_logic/auth/auth_state.dart';
import 'home_screen.dart';

class OtpScreen extends StatefulWidget {

  final String verificationId;

  const OtpScreen({super.key, required this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {

        if (state is AuthSuccess) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ),
            (route) => false,
          );
        }

        if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },

      child: Scaffold(
        appBar: AppBar(title: const Text("Enter OTP")),

        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [

              const SizedBox(height: 30),

              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Enter OTP",
                  border: OutlineInputBorder(),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {

                  context.read<AuthBloc>().add(
                    VerifyOtpEvent(
                      widget.verificationId,
                      otpController.text.trim(),
                    ),
                  );
                },
                child: const Text("Verify OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}