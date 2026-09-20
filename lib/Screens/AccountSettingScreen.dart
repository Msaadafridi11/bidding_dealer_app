// // import 'package:bidding_user/Models/user_model.dart';
// // import 'package:bidding_user/Widgets/CustomTextFormField.dart';
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// //
// // class Accountsettingscreen extends StatefulWidget {
// //   const Accountsettingscreen({super.key});
// //
// //   @override
// //   State<Accountsettingscreen> createState() => _AccountsettingscreenState();
// // }
// //
// // class _AccountsettingscreenState extends State<Accountsettingscreen> {
// //   final _nameController = TextEditingController();
// //   final _emailController = TextEditingController();
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _loadUserData();
// //   }
// //
// //   Future<void> _loadUserData() async {
// //
// //     final dealerData = await FirebaseFirestore.instance
// //         .collection('userModel')
// //         .doc(FirebaseAuth.instance.currentUser?.uid)
// //         .get();
// //
// //     final userModel=UserModel.fromJson(dealerData.data() as Map<String, dynamic>);
// //
// //     if(dealerData.exists){
// //       _nameController.text= userModel.name.toString();
// //       _emailController.text= userModel.email.toString();
// //     }
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey[300],
// //       body: Padding(
// //         padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
// //         child: Column(
// //           children: [
// //             Row(
// //               children: [
// //                 Container(
// //                   width: 35,
// //                   height: 35,
// //                   decoration: BoxDecoration(
// //                       borderRadius: BorderRadius.all(Radius.circular(10)),
// //                       color: Colors.white),
// //                   child: Center(
// //                       child: Icon(
// //                     Icons.arrow_back_ios_rounded,
// //                     size: 15,
// //                   )),
// //                 ),
// //                 SizedBox(
// //                   width: 150,
// //                 ),
// //                 Center(
// //                     child: Text(
// //                   'Account Sccount',
// //                   style: TextStyle(
// //                     fontSize: 15,
// //                   ),
// //                 )),
// //               ],
// //             ),
// //             SizedBox(
// //               height: 20,
// //             ),
// //             Container(
// //               width: double.infinity,
// //               height: 350,
// //               decoration: BoxDecoration(
// //                   borderRadius: BorderRadius.all(Radius.circular(10)),
// //                   color: Colors.white),
// //               child: Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
// //                 child: Column(
// //                   children: [
// //                     Custemtextformfield(
// //                       controller: _nameController,
// //                       hintText: 'Name',
// //                       maxLines: 1,
// //                       readOnly: true,
// //                       filled: false,
// //                       fillColor: null,
// //                       label: Text('Name'),
// //                     ),
// //                     SizedBox(
// //                       height: 20,
// //                     ),
// //                     Custemtextformfield(
// //                       controller: _emailController,
// //                       hintText: 'Email',
// //                       maxLines: 1,
// //                       readOnly: true,
// //                       filled: false,
// //                       fillColor: null,
// //                       label: Text('Email'),
// //                     ),
// //                     SizedBox(
// //                       height: 20,
// //                     ),
// //                     Custemtextformfield(
// //                       controller: null,
// //                       hintText: 'Phone Number',
// //                       maxLines: 1,
// //                       readOnly: true,
// //                       filled: false,
// //                       fillColor: null,
// //                       label: Text('Phone Number'),
// //                     ),
// //                     SizedBox(
// //                       height: 20,
// //                     ),
// //                     Custemtextformfield(
// //                       controller: null,
// //                       hintText: 'Company',
// //                       maxLines: 1,
// //                       readOnly: true,
// //                       filled: false,
// //                       fillColor: null,
// //                       label: Text('Company'),
// //                     ),
// //                     SizedBox(
// //                       height: 20,
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:bidding_user/Models/user_model.dart';
// import 'package:bidding_user/Screens/BottemNevigatonScreen.dart';
// import 'package:bidding_user/Screens/ProfileScreen.dart';
// import 'package:bidding_user/Widgets/CustomTextFormField.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class Accountsettingscreen extends StatefulWidget {
//   const Accountsettingscreen({super.key});
//
//   @override
//   State<Accountsettingscreen> createState() => _AccountsettingscreenState();
// }
//
// class _AccountsettingscreenState extends State<Accountsettingscreen> {
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _phoneController = TextEditingController();
//   final _companyController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUserData();
//   }
//
//   Future<void> _loadUserData() async {
//     final user = FirebaseAuth.instance.currentUser;
//     if (user == null) return;
//
//     final dealerData = await FirebaseFirestore.instance
//         .collection('userModel')
//         .doc(user.uid)
//         .get();
//
//
//
//     if (dealerData.exists && dealerData.data() != null) {
//       final userModel =
//           UserModel.fromJson(dealerData.data() as Map<String, dynamic>);
//       setState(() {
//         _nameController.text = userModel.name ?? '';
//         _emailController.text = userModel.email ?? '';
//         // _phoneController.text = userModel.phone ?? ''; // Ensure these exist in your model
//         // _companyController.text = userModel.company ?? '';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//             child: Column(
//               children: [
//                 // --- CUSTOM HEADER ---
//                 Row(
//                   children: [
//                     InkWell(
//                       onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Bottemnevigatonscreen(),)),
//                       child: Container(
//                         padding: const EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.black.withOpacity(0.05),
//                               blurRadius: 5,
//                             )
//                           ],
//                         ),
//                         child: const Icon(Icons.arrow_back_ios_new, size: 18),
//                       ),
//                     ),
//                     const Expanded(
//                       child: Center(
//                         child: Text(
//                           'Account Settings',
//                           style: TextStyle(
//                             fontSize: 18,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black87,
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 45), // To balance the back button
//                   ],
//                 ),
//
//                 const SizedBox(height: 30),
//
//                 // --- MAIN WHITE CARD ---
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(24),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(20),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.03),
//                         blurRadius: 20,
//                         offset: const Offset(0, 10),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Custemtextformfield(
//                         controller: _nameController,
//                         hintText: 'Name',
//                         maxLines: 1,
//                         readOnly: false,
//                         filled: false,
//                         fillColor: null,
//                         label: Text('Name'),
//                       ),
//                       const SizedBox(height: 20),
//
//                       Custemtextformfield(
//                         controller: _emailController,
//                         hintText: 'Email',
//                         maxLines: 1,
//                         readOnly: true,
//                         filled: false,
//                         fillColor: null,
//                         label: Text('email'),
//                       ),
//                       const SizedBox(height: 20),
//
//                       Custemtextformfield(
//                         controller: null,
//                         hintText: 'phone Number',
//                         maxLines: 1,
//                         readOnly: true,
//                         filled: false,
//                         fillColor: null,
//                         label: Text('phone number'),
//                       ),
//                       const SizedBox(height: 20),
//
//                       Custemtextformfield(
//                         controller: null,
//                         hintText: 'Company',
//                         maxLines: 1,
//                         readOnly: true,
//                         filled: false,
//                         fillColor: null,
//                         label: Text('Compny'),
//                       ),
//                       const SizedBox(height: 20),
//
//                       // --- SAVE BUTTON (Yellow Mark Requirement) ---
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: SizedBox(
//                           width: 150,
//                           height: 55,
//                           child: ElevatedButton(
//
//                             onPressed: () async {
//                               try {
//
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text('Updating data...')),
//                                 );
//
//                                 final String userId = FirebaseAuth.instance.currentUser!.uid;
//
//                                 // Firestore update data
//                                 await FirebaseFirestore.instance
//                                     .collection('userModel')
//                                     .doc(userId)
//                                     .update({
//                                   'name': _nameController.text.trim(),
//                                   'email': _emailController.text.trim(),
//                                   // 'phone': _phoneController.text.trim(),
//                                 });
//
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   const SnackBar(content: Text('Profile Updated Successfully!'), backgroundColor: Colors.green),
//                                 );
//                               } catch (e) {
//                                 ScaffoldMessenger.of(context).showSnackBar(
//                                   SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
//                                 );
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.blue[
//                                   800],
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                             ),
//                             child: const Text(
//                               'Save Changes',
//                               style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 13,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 25,),
//                 Container(
//                   width: double.infinity,
//                   height: 260,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(10))),
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 80, horizontal: 20),
//                     child: Column(
//                       children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text('Account Status',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
//                           Text('ACTIVE',style: TextStyle(fontSize: 15, color: Colors.green, fontWeight: FontWeight.bold),),
//                         ],
//                       ),
//                         SizedBox(height: 40,),
//
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Text('Email Verified',style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
//                             Text('VERIFIED',style: TextStyle(fontSize: 15, color: Colors.green,  fontWeight: FontWeight.bold),),
//                           ],
//                         ),
//                     ],),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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

  @override
  void onInit() {
    super.onInit();
    fetchUserData(); // Screen khulne par data load hoga
  }

  // Firestore se data lane ka function
  Future<void> fetchUserData() async {
    try {
      isLoading(true);
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) return;

      final snap = await FirebaseFirestore.instance
          .collection('userModel')
          .doc(user.uid)
          .get();

      if (snap.exists && snap.data() != null) {
        final data = UserModel.fromJson(snap.data()!);
        nameController.text = data.name ?? '';
        emailController.text = data.email ?? '';
        phoneController.text = data.phoneNum!.toInt() as String;
        companyController.text = data.compnyName ?? '';
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }

  // Data Update karne ka function
  Future<void> updateUserData() async {
    try {
      Get.snackbar("Updating", "Please wait...",
          showProgressIndicator: true, snackPosition: SnackPosition.BOTTOM);

      final uid = FirebaseAuth.instance.currentUser!.uid;
      await FirebaseFirestore.instance.collection('userModel').doc(uid).update({
        'name': nameController.text.trim(),
        'phoneNum': phoneController.text.trim(),
        'compnyName': companyController.text.trim(),

        // Email usually update nahi kiya jata kyunki wo unique ID hoti hai
      });

      Get.snackbar("Success", "Profile Updated Successfully!",
          backgroundColor: Colors.green, colorText: Colors.white);
    } catch (e) {
      Get.snackbar("Error", e.toString(), backgroundColor: Colors.red, colorText: Colors.white);
    }
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
              Get.off(() => const Bottemnevigatonscreen(), routeName: '/Bottemnevigatonscreen');
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
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 20)],
      ),
      child: Column(
        children: [
          Custemtextformfield(
            controller: controller.nameController,
            hintText: 'Name',
            label: const Text('Full Name'), maxLines: null, readOnly: false, filled: null, fillColor: null,
          ),
          const SizedBox(height: 20),
          Custemtextformfield(
            controller: controller.emailController,
            hintText: 'Email', maxLines: null, readOnly: true, filled: null, fillColor: null,
           // Email change nahi hona chahiye safety ke liye
            label: const Text('Email Address'),
          ),
          const SizedBox(height: 20),
          Custemtextformfield(
            controller: controller.phoneController,
            hintText: 'Phone Number', maxLines: null, readOnly: false, filled: null, fillColor: null,
            label: const Text('Phone'),
          ),

          const SizedBox(height: 20),
          Custemtextformfield(
            controller: controller.companyController,
            hintText: 'company', maxLines: null, readOnly: false, filled: null, fillColor: null,
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: const Text('Save Changes',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
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
        Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
        Text(value, style: TextStyle(fontSize: 15, color: color, fontWeight: FontWeight.bold)),
      ],
    );
  }
}