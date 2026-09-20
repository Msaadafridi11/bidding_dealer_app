import 'package:bidding_user/Auththentication/RegistereScreen.dart';
import 'package:bidding_user/Screens/BottemNevigatonScreen.dart';
import 'package:bidding_user/Widgets/CustomTextFormField.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isBusy= false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(child: Text('Login in to Carsxchange',style: TextStyle(fontSize: 20),)),
                   Center(child: Text('Enter your details below',style: TextStyle(fontSize: 12),)),
                   SizedBox(height: 30,),              
                
                  SizedBox(height: 15,),
                   Custemtextformfield(controller: emailController, hintText: 'Login here', maxLines: 1, readOnly: false, filled: true, fillColor: Colors.white,  label: Text('Email address'), validator: (value) {
                     
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },),
                 SizedBox(height: 15,),
                  Custemtextformfield(controller: passwordController, hintText: 'password', maxLines: 1, readOnly: false, filled: true, fillColor: Colors.white,  label: Text('Password'), 
                     validator: (value){
                        if(value==null || value.isEmpty){
                          return 'Please enter your password';
                        }
                        if(value.length<6){
                          return 'Password must be at least 6 characters long';
                        }
                        return null;
                      },
                    ),
                  SizedBox(height: 20,),
                  Text('I agree with Stealthwriter Terms of Service and Privacy Poclicy', style:TextStyle(color: Colors.grey),),
                  SizedBox(height: 20,),
              
                   GestureDetector(
                        onTap: isBusy ? null : () async {
              
                          if (!_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text('please fill all required fields')));
                            return;
                          }
                          setState(() {
                            isBusy=true;
                          });
                          try {                            
                            final userCredential =
                                await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Login Successful')));
                            Get.offAll(() => const Bottemnevigatonscreen(), routeName: '/Bottemnevigatonscreen');
                            debugPrint('User logged in: ${userCredential.user?.email}');
                          } on FirebaseAuthException catch (e) {
                            if (!context.mounted) return;
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Login Failed: ${e.message}')));
                            debugPrint('Login Failed: $e');
                          } finally {
                            if (mounted) {
                              setState(() {
                                isBusy = false;
                              });
                            }
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          height: 50,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(5)),
                          child: Center(
                              child: isBusy? const CircularProgressIndicator(
                                color: Colors.white,
                              ): const
                              Text(
                            'Login',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          )),
                        ),
                      ),
                       Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account? ', style: TextStyle(color: Colors.grey),),
                        InkWell(onTap: () {
                          Get.off(() => const Registerescreen(), routeName: '/Registerescreen');
                        },
                        child: const Text('Login'),
                        )
                      ],
                     ),
                ],
              ),
            ),
          ],
        ),
      ),    
    );
  }
}