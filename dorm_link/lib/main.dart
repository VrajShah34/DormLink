import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:dorm_link/src/features/nowplaying/now_playing_screen.dart';
import 'src/features/complaints/complaints_screen.dart';
import 'src/features/auth/login.dart';
import 'src/features/homepage/home_screen.dart';
import 'src/features/profile/profilepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 217, 233, 253)),
        useMaterial3: true,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    now_playing(),
    Complaints(),
    ProfilePage(),
  ];
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 250, 255),
      body: Center(child: _widgetOptions.elementAt(selectedIndex)),
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
            color: Color.fromARGB(255, 72, 76, 82),
            activeColor: Color.fromARGB(178, 0, 0, 0),
            tabBackgroundColor: Color.fromARGB(255, 241, 250, 255),
            padding: EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.sports_soccer_outlined,
                text: 'Now Playing',
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
