import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// Import the necessary pages for navigation
import 'home.dart';
import 'login.dart';

/// A widget that decides whether to show the Home screen or the Login screen
/// based on the Firebase authentication state.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      // Listen for changes in the user's authentication state
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. Connection State: Waiting for Firebase to initialize/check status
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // 2. Data State: User is logged in (snapshot.hasData is true and snapshot.data is not null)
        if (snapshot.hasData && snapshot.data != null) {
          // User is logged in, show the Home screen.
          return const Home();
        }

        // 3. No Data State: User is NOT logged in
        // Show the Login screen.
        return const Login();
      },
    );
  }
}