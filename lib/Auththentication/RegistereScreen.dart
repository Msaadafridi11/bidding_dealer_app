import 'package:bidding_user/Models/user_model.dart';
import 'package:bidding_user/Screens/DealerWitingScreen.dart';
import 'package:bidding_user/Widgets/CustomTextFormField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Registerescreen extends StatefulWidget {
  const Registerescreen({super.key});

  @override
  State<Registerescreen> createState() => _RegisterescreenState();
}

class _RegisterescreenState extends State<Registerescreen> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneNumController = TextEditingController();
  final compnyNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isBusy = false;

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
                  const Center(
                      child: Text('Register to Carsxchange',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold))),
                  const Center(
                      child: Text('Enter your details below',
                          style: TextStyle(fontSize: 12))),
                  const SizedBox(height: 30),

                  Custemtextformfield(
                    controller: firstNameController,
                    hintText: 'Name',
                    label: const Text('First Name'),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter first name' : null,
                    maxLines: null,
                    readOnly: false,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  const SizedBox(height: 15),

                  Custemtextformfield(
                    controller: lastNameController,
                    hintText: 'Surname',
                    label: const Text('Last Name'),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter last name' : null,
                    maxLines: null,
                    readOnly: false,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  const SizedBox(height: 15),

                  Custemtextformfield(
                    controller: emailController,
                    hintText: 'Email',
                    maxLines: null,
                    readOnly: false,
                    filled: true,
                    fillColor: Colors.white,
                    label: const Text('Email address'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Invalid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),

                  Custemtextformfield(
                    controller: passwordController,
                    hintText: 'Password',
                    label: const Text('Password'),
                    maxLines: null,
                    readOnly: false,
                    filled: true,
                    fillColor: Colors.white,
                    validator: (value) =>
                    (value != null && value.length < 6)
                        ? 'Min 6 characters'
                        : null,
                  ),
                  const SizedBox(height: 15),

                  // Phone Number
                  Custemtextformfield(
                    controller: phoneNumController,
                    hintText: 'Phome Number',
                    label: const Text('Phome Number'),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter Phone Number' : null,
                    maxLines: null,
                    readOnly: false,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  const SizedBox(height: 15),

                  Custemtextformfield(
                    controller: compnyNameController,
                    hintText: 'Compny Name',
                    label: const Text('Compny Name'),
                    validator: (value) =>
                    value!.isEmpty ? 'Please enter Compny Name' : null,
                    maxLines: null,
                    readOnly: false,
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  const SizedBox(height: 30),

                  GestureDetector(
                    onTap: isBusy ? null : _registerUser,
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(5)),
                      child: Center(
                        child: isBusy
                            ? const CircularProgressIndicator(
                            color: Colors.white)
                            : const Text('Register',
                            style: TextStyle(
                                color: Colors.white, fontSize: 18)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => isBusy = true);

    try {

      // Safe convert String → int
      int? phoneNumber =
      int.tryParse(phoneNumController.text.trim());

      //  Prevent crash if invalid number
      if (phoneNumber == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter valid numbers only")),
        );
        setState(() => isBusy = false);
        return;
      }

      final userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      final User? user = userCredential.user;

      if (user != null) {

        final newUser = UserModel(
          name: firstNameController.text.trim(),
          uid: user.uid,
          email: emailController.text.trim(),
          isVerified: false,
          compnyName: compnyNameController.text.trim(),
          phoneNum: phoneNumber, //  CHANGED (was String before)
        );

        await FirebaseFirestore.instance
            .collection('userModel')
            .doc(user.uid)
            .set(newUser.toJson());

        if (!mounted) return;

        Get.offAll(() => const Dealerwitingscreen(), routeName: '/Dealerwitingscreen');
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: ${e.message}')));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally {
      if (mounted) setState(() => isBusy = false);
    }
  }
}
