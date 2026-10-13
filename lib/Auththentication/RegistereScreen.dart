import 'package:bidding_user/Auththentication/LoginScreen.dart';
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
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _companyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isBusy = false;
  bool _obscurePassword = true;
  bool _obscureConfirm = true;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  String _friendlyError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'An account already exists for this email.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'Password is too weak. Use at least 6 characters.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Contact support.';
      case 'network-request-failed':
        return 'No internet connection. Please check your network.';
      default:
        return e.message ?? 'Registration failed. Please try again.';
    }
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isBusy = true);

    User? createdUser;
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      createdUser = userCredential.user;

      if (createdUser == null) {
        throw Exception('Account creation failed. Please try again.');
      }

      final newUser = UserModel(
        name: ' ',
        uid: createdUser.uid,
        email: _emailController.text.trim(),
        isVerified: false,
        compnyName: _companyController.text.trim(),
        phoneNum: int.tryParse(_phoneController.text.trim()) ?? 0,
      );

      await FirebaseFirestore.instance
          .collection('userModel')
          .doc(createdUser.uid)
          .set(newUser.toJson());

      if (!mounted) return;
      Get.offAll(() => const Dealerwitingscreen(),
          routeName: '/Dealerwitingscreen');
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(_friendlyError(e))));
    } catch (e) {
      if (createdUser != null) {
        try { await createdUser.delete(); } catch (_) {}
      }
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Registration failed: '),
        ),
      );
    } finally {
      if (mounted) setState(() => _isBusy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  controller: _firstNameController,
                  hintText: 'First name',
                  label: const Text('First Name'),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Please enter first name'
                      : null,
                  maxLines: 1,
                  readOnly: false,
                  filled: true,
                  fillColor: Colors.white,
                ),
                const SizedBox(height: 15),

                Custemtextformfield(
                  controller: _lastNameController,
                  hintText: 'Last name',
                  label: const Text('Last Name'),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Please enter last name'
                      : null,
                  maxLines: 1,
                  readOnly: false,
                  filled: true,
                  fillColor: Colors.white,
                ),
                const SizedBox(height: 15),

                Custemtextformfield(
                  controller: _emailController,
                  hintText: 'Email',
                  maxLines: 1,
                  readOnly: false,
                  filled: true,
                  fillColor: Colors.white,
                  label: const Text('Email address'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
                      return 'Invalid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                Custemtextformfield(
                  controller: _passwordController,
                  hintText: 'Password',
                  label: const Text('Password'),
                  maxLines: 1,
                  readOnly: false,
                  filled: true,
                  fillColor: Colors.white,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    icon: Icon(_obscurePassword
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () =>
                        setState(() => _obscurePassword = !_obscurePassword),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                Custemtextformfield(
                  controller: _confirmPasswordController,
                  hintText: 'Confirm password',
                  label: const Text('Confirm Password'),
                  maxLines: 1,
                  readOnly: false,
                  filled: true,
                  fillColor: Colors.white,
                  obscureText: _obscureConfirm,
                  suffixIcon: IconButton(
                    icon: Icon(_obscureConfirm
                        ? Icons.visibility_off_outlined
                        : Icons.visibility_outlined),
                    onPressed: () =>
                        setState(() => _obscureConfirm = !_obscureConfirm),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),

                Custemtextformfield(
                  controller: _phoneController,
                  hintText: 'Phone Number',
                  label: const Text('Phone Number'),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter phone number';
                    }
                    if (!RegExp(r'^\+?[0-9]{7,15}$').hasMatch(value.trim())) {
                      return 'Enter a valid phone number (digits only)';
                    }
                    return null;
                  },
                  maxLines: 1,
                  readOnly: false,
                  filled: true,
                  fillColor: Colors.white,
                ),
                const SizedBox(height: 15),

                Custemtextformfield(
                  controller: _companyController,
                  hintText: 'Company Name',
                  label: const Text('Company Name'),
                  validator: (value) => (value == null || value.trim().isEmpty)
                      ? 'Please enter company name'
                      : null,
                  maxLines: 1,
                  readOnly: false,
                  filled: true,
                  fillColor: Colors.white,
                ),
                const SizedBox(height: 30),

                GestureDetector(
                  onTap: _isBusy ? null : _registerUser,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: _isBusy ? Colors.blue.shade300 : Colors.blue,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: _isBusy
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Register',
                              style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Already have an account? ',
                        style: TextStyle(color: Colors.grey)),
                    InkWell(
                      onTap: () => Get.off(() => const Loginscreen(),
                          routeName: '/Loginscreen'),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.blue, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
