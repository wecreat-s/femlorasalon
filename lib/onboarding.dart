import 'package:flutter/material.dart';
import 'signup.dart';  // <-- Make sure this import is correct

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Top Image
            Image.asset(
              "assets/images/fem1.PNG",
              fit: BoxFit.cover,
              width: double.infinity,
              height: size.height * 0.55,
            ),

            // Bottom Section
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 30.0,
                ),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 231, 45, 175),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),

                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Welcome",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 20.0),

                      Text(
                        "Glow. Shine. Slay — with Femlora’s beauty care.",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.yellowAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic,
                          letterSpacing: 0.5,
                        ),
                      ),

                      const SizedBox(height: 40.0),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 80),
                        child: ElevatedButton(
                          onPressed: () {
                            // ➤ Navigate to signup page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Signup(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 50,
                              vertical: 12,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            "Book Now",
                            style: TextStyle(
                              color: Color.fromARGB(255, 231, 45, 175),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

