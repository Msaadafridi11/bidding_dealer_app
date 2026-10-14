import 'package:bidding_user/Auththentication/LoginScreen.dart';
import 'package:bidding_user/Models/user_model.dart';
import 'package:bidding_user/Screens/BlockedDealerScreen.dart';
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
    if (user == null) {
      if (!context.mounted) return;
      Get.offAll(() => const Loginscreen(), routeName: '/Loginscreen');
      return;
    }
    String uid = user.uid;

    try {
      final doc = await FirebaseFirestore.instance
          .collection('userModel')
          .doc(uid)
          .get();

      if (!context.mounted) return;

      if (!doc.exists || doc.data() == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Profile not found. Please contact support.")),
        );
        return;
      }

      final rawData = doc.data() as Map<String, dynamic>;
      UserModel? userModel;
      try {
        userModel = UserModel.fromJson(rawData);
      } catch (_) {
        userModel = null;
      }

      final bool isBlocked = (userModel?.isBlocked ?? false) ||
          (rawData['isBlocked'] as bool? ?? false) ||
          (rawData['status']?.toString().toLowerCase() == 'blocked');

      if (isBlocked) {
        Get.offAll(
          () => const BlockedDealerScreen(),
          routeName: '/BlockedDealerScreen',
        );
        return;
      }

      final bool isVerified =
          userModel?.isVerified ?? (rawData['isVerified'] as bool? ?? false);
      final bool isApproved = rawData['isApproved'] as bool? ?? false;
      final bool isRejected =
          rawData['status']?.toString().toLowerCase() == 'rejected';
      final bool approved = (isVerified || isApproved) && !isRejected;

      if (approved) {
        Get.offAll(
          () => const Bottemnevigatonscreen(),
          routeName: '/Bottemnevigatonscreen',
        );
      } else if (isRejected) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Your registration was rejected by the administrator.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text("Still pending... Please wait for Admin approval.")),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text("Unable to check status. Please try again.")),
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