import 'package:bidding_user/Auththentication/RegistereScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'onboarding2.dart';

class Onboarding3 extends StatelessWidget {
  const Onboarding3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [

                        /// 🔹 TOP BAR (Back only)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            /// BACK ARROW
                            IconButton(
                              icon: const Icon(Icons.arrow_back_ios_new),
                              onPressed: () {
                                if (Navigator.canPop(context)) {
                                  Get.back();
                                } else {
                                  Get.off(() => const Onboarding2(), routeName: '/Onboarding2');
                                }
                              },
                            ),

                            const SizedBox(width: 48), // balance spacing
                          ],
                        ),

                        const SizedBox(height: 30),

                        /// 🔹 IMAGE
                        Image.asset(
                          "assets/illustration 3.png",
                          height: 260,
                          fit: BoxFit.contain,
                        ),

                        const SizedBox(height: 40),

                        /// 🔹 TITLE
                        const Text(
                          "Winning a Car",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 16),

                        /// 🔹 DESCRIPTION
                        const Text(
                          "Win your dream car at the best price and enjoy a smooth buying experience.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),

                        const Spacer(),

                        /// 🔹 DOT INDICATOR
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _dot(false),
                            _dot(false),
                            _dot(true),
                          ],
                        ),

                        const SizedBox(height: 30),

                        /// 🔹 START BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            onPressed: () {
                              Get.offAll(() => const Registerescreen(), routeName: '/Registerescreen');
                            },
                            child: const Text(
                              "Start Now",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  static Widget _dot(bool active) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: active ? 22 : 8,
      decoration: BoxDecoration(
        color: active ? Colors.blue : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
