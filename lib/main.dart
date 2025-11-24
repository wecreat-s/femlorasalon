import 'package:femlorasalon/Admin/admin_login.dart';
import 'package:femlorasalon/auth_gate.dart';
import 'package:femlorasalon/services/constant.dart';
import 'package:femlorasalon/user.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:femlorasalon/services/constant.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'onboarding.dart';
import 'home.dart';
import 'user.dart';

import 'package:femlorasalon/detail_page.dart';
import 'detail_page.dart';
import 'signup.dart';
import 'login.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = publishedKey;

  // Firebase simple initialization (uses google-services.json)
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Femlora Salon',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Onboarding(),
    );
  }
}
