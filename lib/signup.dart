import 'package:flutter/material.dart';
import '../login.dart';
import '../home.dart';
import 'package:femlorasalon/services/database.dart';
import 'package:femlorasalon/services/shared_pref.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final DatabaseService _dbService = DatabaseService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Color primaryPurple = const Color(0xFFF1E27F);
  final Color inputFieldColor = const Color(0xFFF85FD6);
  final Color textWhite = Colors.black;
  final Color textBlack = Colors.black;

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool _isLoading = false;

  void _handleSignup() async {
    if (_formKey.currentState!.validate() && !_isLoading) {
      setState(() {
        _isLoading = true;
      });

      try {
        // 1️⃣ Firebase Authentication
        UserCredential userCredential =
        await _auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        String userId = userCredential.user!.uid;

        // 2️⃣ Firestore user data
        Map<String, dynamic> userInfoMap = {
          "name": _nameController.text.trim(),
          "email": _emailController.text.trim(),
          "createdAt": DateTime.now(),
        };

        // 3️⃣ Save in Firestore
        await _dbService.addUserDetails(userInfoMap, userId);

        // 4️⃣ Save in Shared Preferences
        await SharedPreferenceHelper()
            .saveUserName(_nameController.text.trim());
        await SharedPreferenceHelper()
            .saveUserEmail(_emailController.text.trim());
        await SharedPreferenceHelper().saveUserId(userId);

        // 5️⃣ Success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Registered successfully! 🎉"),
            duration: Duration(seconds: 1),
          ),
        );

        // 6️⃣ Navigate to Home
        await Future.delayed(const Duration(seconds: 1));
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const Home()));
      } on FirebaseAuthException catch (e) {
        String message = '';

        if (e.code == 'weak-password') {
          message = 'Password is too weak.';
        } else if (e.code == 'email-already-in-use') {
          message = 'Email already exists.';
        } else {
          message = e.message ?? 'Something went wrong.';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message), backgroundColor: Colors.red),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Unexpected error: $e'),
              backgroundColor: Colors.red),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: primaryPurple,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding:
              const EdgeInsets.only(top: 20, left: 25, right: 25, bottom: 0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: Image.asset(
                        'assets/images/let.PNG',
                        height: 120,
                      ),
                    ),
                    const SizedBox(height: 50),

                    _buildTextField(
                      controller: _nameController,
                      hintText: 'Name',
                      icon: Icons.person_outline,
                      validator: (value) =>
                      value!.isEmpty ? 'Enter your name.' : null,
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      controller: _emailController,
                      hintText: 'Email',
                      icon: Icons.email_outlined,
                      validator: (value) {
                        if (value!.isEmpty) return 'Enter an email.';
                        if (!value.contains('@')) return 'Invalid email.';
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      controller: _passwordController,
                      hintText: 'Password',
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator: (value) {
                        if (value!.length < 6) {
                          return 'Minimum 6 characters required.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),

                    _buildTextField(
                      controller: _confirmPasswordController,
                      hintText: 'Confirm Password',
                      icon: Icons.lock_outline,
                      obscureText: true,
                      validator: (value) {
                        if (value != _passwordController.text) {
                          return 'Passwords do not match.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 40),

                    // SIGNUP BUTTON
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleSignup,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                            : const Text(
                          "Signup",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Already have an account?",
                            style: TextStyle(color: textBlack)),
                        GestureDetector(
                          onTap: () => Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Login()),
                          ),
                          child: Text(
                            " Login",
                            style: TextStyle(
                              color: textBlack,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 150),
                  ],
                ),
              ),
            ),
          ),

          // Bottom image
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/bt.png',
              width: size.width,
              height: size.height * 0.15,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: inputFieldColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        style: TextStyle(color: textWhite),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: textWhite.withOpacity(0.7)),
          suffixIcon: Icon(icon, color: textWhite),
          border: InputBorder.none,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        ),
      ),
    );
  }
}
