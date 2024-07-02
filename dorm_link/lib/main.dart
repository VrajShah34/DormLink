import 'package:dorm_link/src/admin/home_screen.dart';
import 'package:dorm_link/src/features/auth/login.dart';
import 'package:dorm_link/src/features/utilities/utilities.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'src/features/complaints/complaints_screen.dart';
import 'src/features/homepage/home_screen.dart';
import 'src/features/profile/profilepage.dart';
import 'src/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences preferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    child: MyApp(
        token: preferences.getString("token"),
        isAdmin: preferences.getBool("isAdmin")),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.token, this.isAdmin});

  final token;
  final bool? isAdmin;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Dorm Link',
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        home: token != null
            ? (JwtDecoder.isExpired(token)
                ? LoginPage()
                : isAdmin!
                    ? AdminHomeScreen(token: token)
                    : MyHomePage(
                        token: token,
                      ))
            : LoginPage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.token});

  final String token;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 250, 255),
      body: Center(
          child: [
        HomeScreen(
          token: widget.token,
        ),
        UtilitiesScreen(
          token: widget.token,
        ),
        Complaints(token: widget.token),
        const ProfilePage(),
      ][selectedIndex]),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
        child: GNav(
            tabBorderRadius: 50,
            backgroundColor: Colors.white,
            gap: 4,
            color: const Color.fromARGB(255, 72, 76, 82),
            activeColor: const Color.fromARGB(178, 0, 0, 0),
            tabBackgroundColor: const Color.fromARGB(255, 241, 250, 255),
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.sports_soccer_outlined,
                text: 'Utilities',
              ),
              GButton(
                icon: Icons.note,
                text: 'Complaint Log',
              ),
              GButton(
                icon: Icons.person,
                text: 'Profile',
              ),
            ],
            selectedIndex: selectedIndex,
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            }),
      ),
    );
  }
}
