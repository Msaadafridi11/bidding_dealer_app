import 'package:bidding_user/Auththentication/LoginScreen.dart';
import 'package:bidding_user/Auththentication/ResetPasswordScreen.dart';
import 'package:bidding_user/Models/user_model.dart';
import 'package:bidding_user/Screens/AccountSettingScreen.dart';
import 'package:bidding_user/Screens/LanguageScreen.dart';
import 'package:bidding_user/Screens/MyBidsScreens.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> _signOut() async {
    try {
      //  Tell Firebase to sign out
      await FirebaseAuth.instance.signOut();
      if (!mounted) return;
      Get.offAll(() => const Loginscreen(), routeName: '/Loginscreen');
    } catch (e) {
      //  Handle errors (optional but recommended)
      debugPrint("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    // Null-safe: if somehow called after logout, show a safe loader
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return const Scaffold(
          body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: FutureBuilder(
        future:
            FirebaseFirestore.instance.collection('userModel').doc(uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // Null-safe: handle missing or null data
          final rawData = snapshot.data?.data();
          if (rawData == null) {
            return const Center(child: Text('Profile data not found.'));
          }
          // ignore: unnecessary_cast
          final userModel = UserModel.fromJson(rawData as Map<String, dynamic>);

          bool isVerified = userModel.isVerified ?? false;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
            child: Column(
              children: [
                // 1. Profile Header
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          10,
                        ),
                      )),
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 35,
                        backgroundColor: Colors.blue,
                        child:
                            Icon(Icons.person, size: 40, color: Colors.white),
                      ),
                      const SizedBox(width: 15),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  userModel.name.toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(width: 5),
                                // if virified show blue tick
                                if (isVerified)
                                  const Icon(Icons.verified,
                                      color: Colors.blue, size: 18),
                              ],
                            ),
                            Text(userModel.email.toString(),
                                style: const TextStyle(color: Colors.grey)),
                          ]),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // 2. Menu Options (List)
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: ListView(
                      children: [
                        _buildMenuItem(Icons.settings, "Settings".tr, () {
                          Get.to(() => Accountsettingscreen(), routeName: '/Accountsettingscreen');
                        }),
                        _buildMenuItem(
                            Icons.notifications_none, "Notifications".tr, () {}),

                        _buildMenuItem(Icons.gavel, "My Bids".tr, () {
                          Get.to(() => const Mybidsscreens(), routeName: '/Mybidsscreens');
                        }),

                        _buildMenuItem(Icons.language_outlined, "Language".tr, () {
                          Get.to(() => LanguageScreen(), routeName: '/LanguageScreen');
                        }),

                        _buildMenuItem(
                            Icons.lock_outline,
                            "Reset Password",
                            () {
                              Get.to(() => const Resetpasswordscreen(), routeName: '/Resetpasswordscreen');
                            }
                        ),
                        // Logout Button
                        _buildMenuItem(Icons.logout, "Logout".tr, () async {
                          _showMyDialog(
                              context: context,
                              title: "Sign Out".tr,
                              message: "Sign Out".tr,
                              onConfirm: _signOut);
                        }, isLogout: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Widget for Menu Items
  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap,
      {bool isLogout = false}) {
    return ListTile(
      onTap: onTap,
      leading: Icon(icon, color: isLogout ? Colors.red : Colors.blueGrey),
      title: Text(
        title,
        style: TextStyle(
            color: isLogout ? Colors.red : Colors.black,
            fontWeight: FontWeight.w500),
      ),
      trailing:
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }

  void _showMyDialog({
    required BuildContext context,
    required String title,
    required String message,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text("Are you sure you want to $message?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Closes the dialog
              child: const Text("Cancel"),
            ),
            ElevatedButton(
              onPressed: () {
                onConfirm(); // Executes your logic
                Navigator.pop(context); // Closes the dialog
              },
              child: const Text("Confirm"),
            ),
          ],
        );
      },
    );
  }
}
