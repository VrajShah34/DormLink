import 'dart:convert';
import 'package:dorm_link/main.dart';
import 'package:dorm_link/src/Common_widgets/custombigbutton.dart';
import 'package:dorm_link/src/admin/home_screen.dart';
import 'package:dorm_link/src/features/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dorm_link/src/Common_widgets/customtextfield.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();


  late SharedPreferences preferences;
  final _client = http.Client();
  final _loginUrl = Uri.parse("$baseUrl/auth/login");
  final _registerUrl = Uri.parse("register");

  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPreference();
  }

  void initSharedPreference() async {
    preferences = await SharedPreferences.getInstance();
  }

  // sign user in method
  void logInWithEmail() async {
    http.Response response = await _client.post(_loginUrl,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode({
          "enrollmentNo": usernameController.text.trim(),
          "password": passwordController.text.trim()
        }));
    print(response.statusCode.toString());
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      //await EasyLoading.showSuccess(json["status"]);
      var myToken = json["token"];
      var myName = json["name"];
      var myHostel = json["hostel"];
      var myEnrollmentNo = json["enrollmentNo"];
      var roomNo = json["roomNo"];
      var isAdmin = json["isAdmin"];
      print(json);
      preferences.setString("name", myName);
      preferences.setString("token", myToken);
      preferences.setString("hostel", myHostel);
      preferences.setString("enrollmentNo", myEnrollmentNo);
      preferences.setString('roomNo', roomNo);
      preferences.setBool('isAdmin', isAdmin);

      if(isAdmin){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (ctx) =>
                AdminHomeScreen(
                  token: myToken,
                )));
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Welcome $myName !", style: TextStyle(color: Colors.white),)));
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (ctx) =>
              MyHomePage(
                token: myToken,
              )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.body, style: TextStyle(color: Colors.white),)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .background,
      body: SingleChildScrollView(
        child: SafeArea(
          minimum: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 90),

              // logo
              // const Icon(
              //   Icons.lock,
              //   size: 100,
              // ),
              Text(
                'Login',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    fontSize: 60,
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onBackground),
              ),

              const SizedBox(height: 40),

              // welcome back, you've been missed!
              Text(
                'Welcome back you\'ve been missed!',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              CustomTextField(
                controller: usernameController,
                hintText: 'Enrollment No.',
              ),

              const SizedBox(height: 10),

              // password textfield
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                isPassword: true,
              ),

              const SizedBox(height: 10),

              // forgot password?
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Forgot Password?',
                    style: TextStyle(color: Colors.grey[600]),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // sign in button
              CustomBigButton(
                onTap: logInWithEmail,
                title: "Log In",
              ),

              const SizedBox(height: 50),

              // or continue with
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Or continue with',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // google + apple sign in buttons
              IconButton(
                  onPressed: () {},
                  icon: Image.asset(
                    "assets/images/google.png",
                    height: 40,
                    width: 40,
                  )),

              const SizedBox(height: 20),

              // not a member? register now

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Not a member?',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => RegisterPage()));
                    },
                    child: const Text(
                      'Register now',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
