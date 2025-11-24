import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home_admin.dart';
import 'admin_login.dart';   // ⭐ IMPORT YOUR ADMIN HOME PAGE

class AdminLoginPage extends StatefulWidget {
  const AdminLoginPage({super.key});

  @override
  State<AdminLoginPage> createState() => _AdminLoginPageState();
}

class _AdminLoginPageState extends State<AdminLoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  // 🔥 Admin Login Function (Firestore)
  Future<void> adminLogin() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage("Please enter name & password");
      return;
    }

    setState(() => isLoading = true);

    try {
      // 🔥 Firestore Query
      final QuerySnapshot adminSnapshot = await FirebaseFirestore.instance
          .collection("Admin")
          .where("id", isEqualTo: email)
          .where("password", isEqualTo: password)
          .get();

      if (adminSnapshot.docs.isNotEmpty) {
        showMessage("Welcome !");

        // ⭐ Navigate to Admin Home Page
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => HomeAdmin()),
        );

      } else {
        showMessage("Invalid Name or Password");
      }
    } catch (e) {
      showMessage("Error: $e");
    }

    setState(() => isLoading = false);
  }

  void showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(msg)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // ★ Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/girl.PNG"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // ★ Main UI
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  const SizedBox(height: 240),

                  // ★ Admin Login Title
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 1),
                    decoration: BoxDecoration(
                      color: Colors.pink.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: const Text(
                      "Admin Login",
                      style: TextStyle(
                        fontSize: 34,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ★ Email Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.email, color: Colors.black),
                        border: InputBorder.none,
                        hintText: "Name",
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 18),

                  // ★ Password Field
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.lock, color: Colors.black),
                        border: InputBorder.none,
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.black.withOpacity(0.7)),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // ★ Login Button
                  Center(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      onPressed: isLoading ? null : adminLogin,
                      child: isLoading
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

