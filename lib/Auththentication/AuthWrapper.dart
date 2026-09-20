import 'package:bidding_user/AnimationScreen/SplashScreen.dart';
import 'package:bidding_user/Models/user_model.dart';
import 'package:bidding_user/Screens/BottemNevigatonScreen.dart';
import 'package:bidding_user/Screens/DealerWitingScreen.dart';
import 'package:bidding_user/Screens/SomethingWentWrongScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

// class _AuthWrapperState extends State<AuthWrapper> {
//   @override
//   Widget build(BuildContext context) {
//     return// main.dart mein jo home: property hoti hai wahan ye logic hona chahiye
//       // main.dart mein jo home: property hoti hai wahan ye logic hona chahiye
//       StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             // User login hai, ab Firestore se uska status check karo
//             return FutureBuilder<DocumentSnapshot>(
//               future: FirebaseFirestore.instance.collection('userModel').doc(snapshot.data!.uid).get(),
//               builder: (context, userSnapshot) {
//                 if (userSnapshot.connectionState == ConnectionState.waiting) return Center(child: const CircularProgressIndicator());
//
//                 if (userSnapshot.hasData && userSnapshot.data!.exists) {
//                   final userModel= UserModel.fromJson(snapshot.data as Map<String, dynamic>);
//                   bool isVerified = userModel.isVerified ?? false;
//
//                   if (isVerified) {
//                     return const Loginscreen(); // Agar verified hai toh Home
//                   } else {
//                     return const Dealerwitingscreen(); // Agar verified nahi hai toh Waiting
//                   }
//                 }
//                 return const SomethingWentWrongScreen();
//               },
//             );
//           }
//           return const Registerescreen(); // Agar login nahi hai toh Login screen
//         },
//       );}}


class _AuthWrapperState extends State<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // 1. Agar user login nahi hai toh seedha Register/Login par bhejo
        if (!snapshot.hasData) {
          return const SplashScreen();
        }

        // 2. User login hai, ab Firestore se status check karo
        // Maine FutureBuilder ko hata kar StreamBuilder lagaya hai taaki verification LIVE ho
        return StreamBuilder<DocumentSnapshot>(
          stream: FirebaseFirestore.instance
              .collection('userModel')
              .doc(snapshot.data!.uid)
              .snapshots(),
          builder: (context, userSnapshot) {
            if (userSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            if (userSnapshot.hasData && userSnapshot.data!.exists) {
              // DATA MAPPING FIX:
              // userSnapshot.data() ko Map mein convert kar ke model banana hai
              Map<String, dynamic> data = userSnapshot.data!.data() as Map<String, dynamic>;
              final userModel = UserModel.fromJson(data);

              bool isVerified = userModel.isVerified ?? false;

              if (isVerified) {
                // NAVIGATION FIX:
                // Verified user ko Home screen par bhejna hai
                return const Bottemnevigatonscreen();
              } else {
                // Agar verified nahi hai toh Waiting screen
                return const Dealerwitingscreen();
              }
            }

            // Agar Firestore mein data nahi mila
            return const SomethingWentWrongScreen();
          },
        );
      },
    );
  }
}
