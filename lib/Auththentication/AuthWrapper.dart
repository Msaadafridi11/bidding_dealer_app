import 'package:bidding_user/AnimationScreen/SplashScreen.dart';
import 'package:bidding_user/Auththentication/LoginScreen.dart';
import 'package:bidding_user/Models/user_model.dart';
import 'package:bidding_user/Screens/BottemNevigatonScreen.dart';
import 'package:bidding_user/Screens/DealerWitingScreen.dart';
import 'package:bidding_user/Screens/SomethingWentWrongScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  /// null = still loading SharedPrefs
  /// true  = first install → show splash/onboarding chain
  /// false = returning user  → go straight to Login
  bool? _isFirstLaunch;

  @override
  void initState() {
    super.initState();
    _checkFirstLaunch();
  }

  Future<void> _checkFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    final seen = prefs.getBool('hasSeenOnboarding') ?? false;
    if (mounted) setState(() => _isFirstLaunch = !seen);
  }

  @override
  Widget build(BuildContext context) {
    // Still loading SharedPreferences
    if (_isFirstLaunch == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {
        // Auth SDK still initializing
        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        }

        // ── NOT LOGGED IN ─────────────────────────────────────────────────
        if (!authSnapshot.hasData || authSnapshot.data == null) {
          if (_isFirstLaunch == true) {
            // First-ever install: play the splash → onboarding chain.
            // SplashScreen/Loading3 will mark hasSeenOnboarding=true before
            // finishing so the next cold start skips the chain.
            return const SplashScreen();
          }
          // Returning user who is logged out → straight to Login
          return const Loginscreen();
        }

        // ── LOGGED IN — check Firestore for admin approval status ─────────
        final uid = authSnapshot.data!.uid;
        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('userModel')
              .doc(uid)
              .snapshots(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(
                  body: Center(child: CircularProgressIndicator()));
            }

            if (userSnapshot.hasData && userSnapshot.data!.exists) {
              final data =
                  userSnapshot.data!.data() as Map<String, dynamic>;
              final userModel = UserModel.fromJson(data);
              final isVerified = userModel.isVerified ?? false;

              return isVerified
                  ? const Bottemnevigatonscreen()
                  : const Dealerwitingscreen();
            }

            // Firestore doc missing — show recoverable error screen
            return const SomethingWentWrongScreen(
              errorMessage: 'Your profile could not be found.',
            );
          },
        );
      },
    );
  }
}
