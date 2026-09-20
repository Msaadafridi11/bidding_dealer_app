import 'package:bidding_user/Auththentication/EmailSuccessScreen.dart';
import 'package:bidding_user/Screens/BottemNevigatonScreen.dart';
import 'package:bidding_user/Widgets/CustomTextFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Resetpasswordscreen extends StatefulWidget {
  const Resetpasswordscreen({super.key});

  @override
  State<Resetpasswordscreen> createState() => _ResetpasswordscreenState();
}

class _ResetpasswordscreenState extends State<Resetpasswordscreen> {
  bool _isLoading = false;
  final _resetPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Get.back();
                      } else {
                        Get.offAll(() => const Bottemnevigatonscreen(), routeName: '/Bottemnevigatonscreen');
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 5,
                          )
                        ],
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Reset Password',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            const SizedBox(height: 30),
            Center(
                child: Text(
              "Please enter the email address accoloted with your account we'll email you a link to reset your password",
            )),
            const SizedBox(height: 30),
            Custemtextformfield(
                controller: _resetPasswordController,
                hintText: "Email address",
                maxLines: 1,
                readOnly: false,
                filled: null,
                fillColor: null,
                label: null),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null // Jab loading ho raha ho to button disable ho jaye
                    : () async {
                        if (_resetPasswordController.text.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("Please enter your email")),
                          );
                          return;
                        }

                        setState(() => _isLoading = true); // Loading shuru

                        try {
                          await FirebaseAuth.instance.sendPasswordResetEmail(
                            email: _resetPasswordController.text.trim(),
                          );

                          Get.to(
                            () => const EmailSuccessScreen(),
                            routeName: '/EmailSuccessScreen',
                          );

                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'Password reset link sent to your email!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          }
                        } catch (e) {
                          // Error handling (e.g. invalid email)
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Error: ${e.toString()}'),
                                  backgroundColor: Colors.red),
                            );
                          }
                        } finally {
                          if (mounted) {
                            setState(
                                () => _isLoading = false); // Loading khatam
                          }
                        }
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white) // Loading spinner
                    : const Text(
                        'Send Reset Link', // Correct text for this action
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
  }
}
