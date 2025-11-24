import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../signup.dart';
import '../home.dart'; // 👈 Make sure this path matches your folder

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // --- Colors ---
  final Color primaryLavender = const Color(0xFFE6E0F1);
  final Color darkGreen = const Color(0xFF385E38);
  final Color goldAccentLight = const Color(0xFFD4AF37);
  final Color goldAccentDark = const Color(0xFFB08D0E);
  final Color fieldBackgroundColor = Colors.white;
  final Color buttonShadowColor = const Color(0xFFCCB38C);

  // --- Controllers & Form Key ---
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  // --- Login Function ---
  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // ✅ Navigate to Home page after successful login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      } on FirebaseAuthException catch (e) {
        String message = 'User Not Found';
        if (e.code == 'wrong-password') message = 'Incorrect Password';
        if (e.code == 'invalid-email') message = 'Invalid Email';
        if (e.code == 'user-disabled') message = 'User Account Disabled';

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    }
  }

  void _navigateToSignup() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Signup()),
    );
  }

  void _navigateToForgotPassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Forgot Password pressed')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryLavender,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Top Background Image ---
              Container(
                height: MediaQuery.of(context).size.height * 0.35,
                width: double.infinity,
                color: primaryLavender,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Positioned.fill(
                      child: Image.asset(
                        'assets/images/bg1.jpg', // make sure image exists
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                    Positioned(
                      top: 10,
                      right: 15,
                      child: Icon(Icons.shield_outlined,
                          color: goldAccentLight, size: 30),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20.0),

              Column(
                children: [
                  _buildGoldText('WELCOME BACK', fontSize: 18),
                  _buildGoldText('LOGIN',
                      fontSize: 36, letterSpacing: 1.5),
                ],
              ),

              const SizedBox(height: 20.0),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // --- Email Field ---
                      _buildTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        icon: Icons.email_outlined,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter your email.';
                          if (!value.contains('@') || !value.contains('.'))
                            return 'Enter a valid email.';
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // --- Password Field ---
                      _buildPasswordTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return 'Please enter your password.';
                          if (value.length < 6)
                            return 'Password must be at least 6 characters.';
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // --- Forgot Password ---
                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: _navigateToForgotPassword,
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: goldAccentDark,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // --- LOGIN Button ---
                      SizedBox(
                        height: 55,
                        child: ElevatedButton(
                          onPressed: _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: goldAccentLight,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            elevation: 5,
                            shadowColor: buttonShadowColor,
                          ),
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // --- Signup Link ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'New User? ',
                            style: TextStyle(
                                color: goldAccentDark, fontSize: 16),
                          ),
                          GestureDetector(
                            onTap: _navigateToSignup,
                            child: Text(
                              'Signup',
                              style: TextStyle(
                                color: goldAccentLight,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                decoration: TextDecoration.underline,
                                decorationColor: goldAccentLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- Helper Widgets ---

  Widget _buildGoldText(String text,
      {double fontSize = 16, double letterSpacing = 0}) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: [goldAccentLight, goldAccentDark],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(bounds),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          letterSpacing: letterSpacing,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fieldBackgroundColor,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: TextStyle(color: darkGreen),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: darkGreen.withOpacity(0.5)),
          suffixIcon:
          Icon(icon, color: darkGreen.withOpacity(0.7)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 18.0, horizontal: 20.0),
        ),
      ),
    );
  }

  Widget _buildPasswordTextField({
    required TextEditingController controller,
    required String hintText,
    String? Function(String?)? validator,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: fieldBackgroundColor,
        borderRadius: BorderRadius.circular(30.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: !_isPasswordVisible,
        validator: validator,
        style: TextStyle(color: darkGreen),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: darkGreen.withOpacity(0.5)),
          suffixIcon: IconButton(
            icon: Icon(
              _isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: darkGreen.withOpacity(0.7),
            ),
            onPressed: () {
              setState(() {
                _isPasswordVisible = !_isPasswordVisible;
              });
            },
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
              vertical: 18.0, horizontal: 20.0),
        ),
      ),
    );
  }
}
