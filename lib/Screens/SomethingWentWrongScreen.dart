import 'package:bidding_user/Auththentication/LoginScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SomethingWentWrongScreen extends StatelessWidget {
  final String errorMessage;
  const SomethingWentWrongScreen(
      {super.key, this.errorMessage = 'Something went wrong!'});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off_rounded, size: 80, color: Colors.redAccent),
              const SizedBox(height: 20),
              const Text(
                'Connection Issue!',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                "We're having trouble loading your profile. Please check your internet or try again later.\n\nDetails: $errorMessage",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Get.offAll(() => const Loginscreen(),
                      routeName: '/Loginscreen');
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again / Logout'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
