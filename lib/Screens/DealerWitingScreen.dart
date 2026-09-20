import 'package:bidding_user/Auththentication/LoginScreen.dart';
import 'package:bidding_user/Models/user_model.dart';
import 'package:bidding_user/Screens/BottemNevigatonScreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Dealerwitingscreen extends StatefulWidget {
  const Dealerwitingscreen({super.key});

  @override
  State<Dealerwitingscreen> createState() => _DealerwitingscreenState();
}

class _DealerwitingscreenState extends State<Dealerwitingscreen> {
  // Status check karne ka function
  void checkApprovalStatus(BuildContext context) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;
    String uid = user.uid;

    final doc = await FirebaseFirestore.instance
        .collection('userModel')
        .doc(uid)
        .get();
    
    if (!context.mounted || doc.data() == null) return;

    final userModel = UserModel.fromJson(doc.data() as Map<String, dynamic>);

    bool isVerified = userModel.isVerified ?? false;

    if (isVerified) {
      Get.offAll(
        () => const Bottemnevigatonscreen(),
        routeName: '/Bottemnevigatonscreen',
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Still pending... Please wait for Admin approval.")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ek pyara sa animation ya icon
              const Icon(Icons.hourglass_empty_rounded, size: 80, color: Colors.blue),
              const SizedBox(height: 30),

              const Text(
                "Registration Pending",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 15),

              const Text(
                "Your details have been submitted to our team. Please allow up to 24 hours for verification.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),

              const SizedBox(height: 40),

              // Status Check Button
              ElevatedButton(
                onPressed: () => checkApprovalStatus(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Check My Status", style: TextStyle(color: Colors.white)),
              ),

              const SizedBox(height: 15),

              TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if (!mounted) return;
                  Get.offAll(() => const Loginscreen(), routeName: '/Loginscreen');
                },
                child: const Text("Logout & Exit", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}