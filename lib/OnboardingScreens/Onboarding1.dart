import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'onboarding2.dart';
import 'onboarding3.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Get.off(() => const Onboarding3(), routeName: '/Onboarding3');
            },
            child: const Text(
              "Skip",
              style: TextStyle(color: Colors.grey),
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [

                      const SizedBox(height: 40),

                      /// 🔵 YOUR IMAGE HERE
                      Image.asset(
                        "assets/illustration 1.png",
                        height: 260,
                        fit: BoxFit.contain,
                      ),

                      const SizedBox(height: 40),

                      const Text(
                        "Selecting a Car",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      const Text(
                        "Find your desired car and start bidding easily with our smart auction system.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),

                      const Spacer(),

                      /// DOTS
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _dot(true),
                          _dot(false),
                          _dot(false),
                        ],
                      ),

                      const SizedBox(height: 30),

                      /// BUTTON
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: () {
                            Get.to(() => const Onboarding2(), routeName: '/Onboarding2');
                          },
                          child: const Text("Next"),
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
    );
  }

  static Widget _dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: active ? 20 : 8,
      decoration: BoxDecoration(
        color: active ? Colors.blue : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
