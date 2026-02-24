import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../business_logic/auth/auth_bloc.dart';
import '../../business_logic/auth/auth_event.dart';
import '../../data/repositories/auth_repository.dart';

class GuardHomeScreen extends StatelessWidget {
  const GuardHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthRepository().getCurrentUser();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Guard Home"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(SignOutEvent());
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50,
              child: Icon(Icons.person, size: 50),
            ),
            const SizedBox(height: 20),
            Text("Phone: ${user?.phoneNumber ?? 'Unknown'}"),
            const SizedBox(height: 20),
            const Text("Welcome to Guard Booking System!", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Feature coming soon!")),
                );
              },
              child: const Text("Go Online"),
            ),
          ],
        ),
      ),
    );
  }
}
