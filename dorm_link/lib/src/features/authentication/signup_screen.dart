import 'package:dorm_link/src/Common_widgets/custombigbutton.dart';
import 'package:dorm_link/src/features/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../main.dart';
import '../../Common_widgets/customappbar.dart';
import '../../Common_widgets/customtextfield.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  // Future registerUser() async {
  //   try {
  //     if (_formKey.currentState!.validate()) {
  //       _formKey.currentState!.save();
  //
  //       await FirebaseAuth.instance.createUserWithEmailAndPassword(
  //           email: _enteredEmail, password: _enteredPassword);
  //
  //       Navigator.pop(context);
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     showDialog(
  //         context: context,
  //         builder: (context) {
  //           return AlertDialog(
  //             icon: Icon(Icons.error_outline),
  //             iconColor: Colors.redAccent,
  //             title: Text(
  //               SignupWithEmailAndPasswordFailure.code(e.code).message,
  //               style: GoogleFonts.urbanist(color: Colors.redAccent),
  //             ),
  //           );
  //         });
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 250, 255),
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          const Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Row(
              children: [
                CustomAppBar(title: "Sign Up"),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        const Text('Create Account',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w500)),
                        const SizedBox(height: 20),
                        CustomTextField(
                            controller: nameController, hintText: "Your Name"),
                        const SizedBox(height: 10),
                        CustomTextField(
                            controller: emailController, hintText: "Your Email"),
                        const SizedBox(height: 10),
                        CustomTextField(
                            controller: phoneController,
                            hintText: "Your Phone No."),
                        const SizedBox(height: 10),
                        CustomTextField(
                            controller: passwordController, hintText: "Password"),
                        const SizedBox(height: 20),
                        CustomBigButton(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            },
                            title: "Continue"),
                        const SizedBox(height: 10),
                        Text(
                          'or continue with',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[600]),
                        ),
                        const SizedBox(height: 10),
                        SocialLoginButton(
                            buttonType: SocialLoginButtonType.google,
                            backgroundColor: Color.fromARGB(255, 241, 250, 255),
                            borderRadius: 20,
                            onPressed: () {}),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Have account? ',
                              style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.grey[400],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              LoginPage()));
                                });
                              },
                              child: const Text('Log In',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF4A9DFF),
                                  )),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
