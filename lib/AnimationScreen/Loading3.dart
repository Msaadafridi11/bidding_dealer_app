import 'package:bidding_user/OnboardingScreens/Onboarding1.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loading3 extends StatefulWidget {
  const Loading3({super.key});

  @override
  State<Loading3> createState() => _Loading3State();
}

class _Loading3State extends State<Loading3> {

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      if (!mounted) return;
      // Mark onboarding as seen so it never replays on the next cold start
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('hasSeenOnboarding', true);
      if (!mounted) return;
      Get.off(() => const Onboarding1(), routeName: '/Onboarding1');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: LinearProgressIndicator(),
      ),
    );
  }
}
