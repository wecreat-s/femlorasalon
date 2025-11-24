import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // <<< ADDED FIREBASE AUTH IMPORT
// Note: Assuming 'login.dart' is in the same directory.
import 'login.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  // --- LOGIC FUNCTIONS ---

  void _handleLogout(BuildContext context) async { // <<< MADE ASYNC TO AWAIT SIGNOUT
    // 1. Show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Logout Successful!")),
    );

    // ⚠️ CRITICAL FIX: Sign out the user from Firebase
    await FirebaseAuth.instance.signOut();

    // 2. Navigate to Login page and clear all previous routes (session end)
    Navigator.of(context).pushAndRemoveUntil(
      // The Login class is a StatefulWidget, so we do not use const here.
      MaterialPageRoute(builder: (_) => const Login()),
          (Route<dynamic> route) => true,
    );
  }

  void _handleDeleteAccount(BuildContext context) {
    // 1. Show SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Account Deleted Successfully!")),
    );

    // 2. Navigate to a blank page and clear all previous routes (as requested)
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const BlankSuccessPage()),
          (Route<dynamic> route) => false,
    );
  }
  // --- END LOGIC FUNCTIONS ---

  @override
  Widget build(BuildContext context) {
    // Height of the entire header section (Title + Image area)
    const double headerHeight = 250;

    return Scaffold(
      backgroundColor: const Color(0xFFFBF7F2), // Light background color

      body: SingleChildScrollView(
        child: Column(
          children: [
            // Top section (Title and Image area)
            Container(
              padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 20, bottom: 10),
              color: const Color(0xFFEAE253), // Top bar color
              width: double.infinity,
              height: headerHeight, // Set a fixed height for the header area

              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // Centered "USER PROFILE" Title
                  const Positioned(
                    top: 5,
                    left: 0,
                    right: 0,
                    child: Text(
                      "USER PROFILE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),

                  // Profile Picture
                  Positioned(
                    top: 50,
                    left: MediaQuery.of(context).size.width / 2 - 60,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFFFBF7F2),
                        border: Border.all(color: Colors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/images/lady.PNG', // Your image path
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 80, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),

                  // Content Section
                  Positioned(
                    top: headerHeight - 30,
                    left: 0,
                    right: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFC5BDF4), // Content background color
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const SizedBox(height: 50),

                          // Detail Fields
                          const ProfileDetailCard(
                            icon: Icons.person,
                            label: "Name",
                            value: "Olivia Fernandes",
                          ),
                          const SizedBox(height: 15),
                          const ProfileDetailCard(
                            icon: Icons.mail,
                            label: "Email",
                            value: "oliviafern26@gmail.com",
                          ),
                          const SizedBox(height: 15),

                          // --- LOGOUT ACTION CARD (Using GestureDetector) ---
                          ProfileActionCard(
                            icon: Icons.logout,
                            label: "LogOut",
                            onTapWithContext: _handleLogout,
                          ),
                          const SizedBox(height: 15),

                          // --- DELETE ACCOUNT ACTION CARD (Using GestureDetector) ---
                          ProfileActionCard(
                            icon: Icons.delete,
                            label: "Delete Account",
                            onTapWithContext: _handleDeleteAccount,
                          ),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Widget for Profile Detail Cards (Name, Email)
class ProfileDetailCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const ProfileDetailCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE03CFA), // Card color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Custom Widget for Profile Action Cards (Logout, Delete Account) using GestureDetector
class ProfileActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  // This function takes the context, allowing it to perform navigation and show SnackBars.
  final void Function(BuildContext context) onTapWithContext;

  const ProfileActionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.onTapWithContext,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTapWithContext(context), // The action is triggered here
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: const Color(0xFFE03CFA), // Card color
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 28),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 20),
          ],
        ),
      ),
    );
  }
}

// Blank Success Page (Required for Delete Account Navigation)
class BlankSuccessPage extends StatelessWidget {
  const BlankSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text('Operation Completed', style: TextStyle(color: Colors.black54)),
      ),
    );
  }
}