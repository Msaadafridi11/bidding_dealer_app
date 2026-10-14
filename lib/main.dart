import 'package:bidding_user/AnimationScreen/Loading1.dart';
import 'package:bidding_user/AnimationScreen/Loading2.dart';
import 'package:bidding_user/AnimationScreen/Loading3.dart';
import 'package:bidding_user/AnimationScreen/SplashScreen.dart';
import 'package:bidding_user/Auththentication/AuthWrapper.dart';
import 'package:bidding_user/Auththentication/EmailSuccessScreen.dart';
import 'package:bidding_user/Auththentication/LoginScreen.dart';
import 'package:bidding_user/Auththentication/RegistereScreen.dart';
import 'package:bidding_user/Auththentication/ResetPasswordScreen.dart';
import 'package:bidding_user/Models/item_model.dart';
import 'package:bidding_user/OnboardingScreens/Onboarding1.dart';
import 'package:bidding_user/OnboardingScreens/Onboarding2.dart';
import 'package:bidding_user/OnboardingScreens/Onboarding3.dart';
import 'package:bidding_user/Screens/AccountSettingScreen.dart';
import 'package:bidding_user/Screens/BlockedDealerScreen.dart';
import 'package:bidding_user/Screens/BottemNevigatonScreen.dart';
import 'package:bidding_user/Screens/CarDetailScreen.dart';
import 'package:bidding_user/Screens/DealerWitingScreen.dart';
import 'package:bidding_user/Screens/LanguageScreen.dart';
import 'package:bidding_user/Screens/MyBidsScreens.dart';
import 'package:bidding_user/Screens/MyTranslations.dart';
import 'package:bidding_user/Screens/WinnerScreen.dart';
import 'package:bidding_user/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bidding App',

      // --- Localization Setup ---
      translations: MyTranslations(),
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),

      // Theme aur baqi settings
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),

      home: const AuthWrapper(),
      getPages: [
        GetPage(name: '/AuthWrapper', page: () => const AuthWrapper()),
        GetPage(name: '/SplashScreen', page: () => const SplashScreen()),
        GetPage(name: '/Loading1', page: () => const Loading1()),
        GetPage(name: '/Loading2', page: () => const Loading2()),
        GetPage(name: '/Loading3', page: () => const Loading3()),
        GetPage(name: '/Onboarding1', page: () => const Onboarding1()),
        GetPage(name: '/Onboarding2', page: () => const Onboarding2()),
        GetPage(name: '/Onboarding3', page: () => const Onboarding3()),
        GetPage(name: '/Loginscreen', page: () => const Loginscreen()),
        GetPage(name: '/Registerescreen', page: () => const Registerescreen()),
        GetPage(name: '/Dealerwitingscreen', page: () => const Dealerwitingscreen()),
        GetPage(name: '/BlockedDealerScreen', page: () => const BlockedDealerScreen()),
        GetPage(name: '/Bottemnevigatonscreen', page: () => const Bottemnevigatonscreen()),
        GetPage(name: '/Resetpasswordscreen', page: () => const Resetpasswordscreen()),
        GetPage(name: '/EmailSuccessScreen', page: () => const EmailSuccessScreen()),
        GetPage(name: '/Accountsettingscreen', page: () => Accountsettingscreen()),
        GetPage(name: '/LanguageScreen', page: () => LanguageScreen()),
        GetPage(name: '/Mybidsscreens', page: () => const Mybidsscreens()),
        GetPage(
          name: '/WinnerScreen',
          page: () => WinnerScreen(
            itemData: Get.arguments is ItemModel ? Get.arguments as ItemModel : ItemModel(),
          ),
        ),
        GetPage(
          name: '/Cardetailscreen',
          page: () => Cardetailscreen(
            itemData: Get.arguments is ItemModel ? Get.arguments as ItemModel : ItemModel(),
          ),
        ),
      ],
    );
  }
}