import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:bidding_user/Models/user_model.dart';
import 'package:bidding_user/Screens/BottemNevigatonScreen.dart';
import 'package:bidding_user/Widgets/CustomTextFormField.dart';

// ==========================================
// 1. GETX CONTROLLER (Logic Part)
// ==========================================
class AccountController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final companyController = TextEditingController();

  var isLoading = false.obs; // Loading state check
  StreamSubscription<DocumentSnapshot>? _userDataSubscription;

  @override
  void onInit() {
    super.onInit();
    fetchUserData(); // Screen khulne par data load hoga
  }

  // Firestore se real-time data lane ka function
  void fetchUserData() {
    try {
      isLoading(true);
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        isLoading(false);
        return;
      }

      _userDataSubscription?.cancel();
      _userDataSubscription = FirebaseFirestore.instance
          .collection('userModel')
          .doc(user.uid)
          .snapshots()
          .listen((snap) {
        isLoading(false);
        if (snap.exists && snap.data() != null) {
          final raw = snap.data();
          if (raw is Map<String, dynamic>) {
            UserModel? data;
            try {
              data = UserModel.fromJson(raw);
            } catch (_) {
              data = null;
            }
            nameController.text =
                data?.name ?? raw['name']?.toString() ?? '';
            emailController.text =
                data?.email ?? raw['email']?.toString() ?? '';
            phoneController.text = data?.phoneNum?.toString() ??
                raw['phoneNum']?.toString() ??
                '';
            companyController.text = data?.compnyName ??
                raw['compnyName']?.toString() ??
                raw['companyName']?.toString() ??
                '';
          }
        }
      }, onError: (e) {
        isLoading(false);
        Get.snackbar("Error", e.toString(),
            snackPosition: SnackPosition.BOTTOM);
      });
    } catch (e) {
      isLoading(false);
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  // Data Update karne ka function
  Future<void> updateUserData() async {
    try {
      Get.snackbar("Updating", "Please wait...",
          showProgressIndicator: true, snackPosition: SnackPosition.BOTTOM);

      final uid = FirebaseAuth.instance.currentUser!.uid;
      final phoneText = phoneController.text.trim();
      final phoneParsed = int.tryParse(phoneText);

      await FirebaseFirestore.instance.collection('userModel').doc(uid).set({
        'name': nameController.text.trim(),
        'phoneNum': phoneParsed,
        'compnyName': companyController.text.trim(),
        'companyName': companyController.text.trim(),
      }, SetOptions(merge: true));

      Get.snackbar("Success", "Profile Updated Successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString(),
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    _userDataSubscription?.cancel();
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    companyController.dispose();
    super.onClose();
  }
}

// ==========================================
// 2. VIEW (UI Part)
// ==========================================
class Accountsettingscreen extends StatelessWidget {
  Accountsettingscreen({super.key});

  // Controller ko yahan inject kar rahe hain
  final controller = Get.put(AccountController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Obx(() {
          // Agar data load ho raha hai to loader dikhao
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(height: 30),
                _buildFormCard(),
                const SizedBox(height: 25),
                _buildStatusCard(),
              ],
            ),
          );
        }),
      ),
    );
  }

  // --- Header Widget ---
  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            if (Navigator.canPop(context)) {
              Get.back();
            } else {
              Get.off(() => const Bottemnevigatonscreen(),
                  routeName: '/Bottemnevigatonscreen');
            }
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
            ),
            child: const Icon(Icons.arrow_back_ios_new, size: 18),
          ),
        ),
        const Expanded(
          child: Center(
            child: Text('Account Settings',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ),
        const SizedBox(width: 45),
      ],
    );
  }

  // --- Form Card Widget ---
  Widget _buildFormCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20)
        ],
      ),
      child: Column(
        children: [
          Custemtextformfield(
            controller: controller.nameController,
            hintText: 'Name',
            label: const Text('Full Name'),
            maxLines: null,
            readOnly: false,
            filled: null,
            fillColor: null,
          ),
          const SizedBox(height: 20),
          Custemtextformfield(
            controller: controller.emailController,
            hintText: 'Email', maxLines: null, readOnly: true, filled: null,
            fillColor: null,
            // Email change nahi hona chahiye safety ke liye
            label: const Text('Email Address'),
          ),
          const SizedBox(height: 20),
          Custemtextformfield(
            controller: controller.phoneController,
            hintText: 'Phone Number',
            maxLines: null,
            readOnly: false,
            filled: null,
            fillColor: null,
            label: const Text('Phone'),
          ),

          const SizedBox(height: 20),
          Custemtextformfield(
            controller: controller.companyController,
            hintText: 'company',
            maxLines: null,
            readOnly: false,
            filled: null,
            fillColor: null,
            label: const Text('company'),
          ),
          const SizedBox(height: 30),

          // Save Button
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () => controller.updateUserData(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue[800],
                minimumSize: const Size(150, 50),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save Changes',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  // --- Status Card Widget ---
  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Column(
        children: [
          _statusRow('Account Status', 'ACTIVE', Colors.green),
          const Divider(height: 40),
          _statusRow('Email Verified', 'VERIFIED', Colors.green),
        ],
      ),
    );
  }

  Widget _statusRow(String title, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        Text(value,
            style: TextStyle(
                fontSize: 15, color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
