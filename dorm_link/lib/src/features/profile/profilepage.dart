import 'package:dorm_link/src/Common_widgets/customappbar.dart';
import 'package:dorm_link/src/features/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';

// import 'package:google_nav_bar/google_nav_bar.dart';
// import './main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = '';
  String enrollmentNum = '';
  String hostel = '';
  String roomNum = '';

  @override
  void initState() {
    _fetchInfo();
    super.initState();
  }

  void _fetchInfo() {
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        name = prefs.getString('name') ?? '';
        enrollmentNum = prefs.getString('enrollmentNo') ?? '';
        hostel = prefs.getString('hostel') ?? '';
        roomNum = prefs.getString('roomNo') ?? '';
      });
    });
  }

  void logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => LoginPage()));
  }

  Future<void> _launchCaller() async {
    const url = "tel:8860559474";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 250, 255),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CustomAppBar(title: "Profile"),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: IconButton(
                    onPressed: logOut,
                    icon: const Icon(Icons.logout_outlined),
                    iconSize: 35,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            child: Column(
              children: [
                Initicon(
                  text: name,
                  size: 100,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Center(
                      child: Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 24,
                      color: Color(0xFF2B2E35),
                    ),
                  )),
                ),
                Container(
                  child: Text(enrollmentNum,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF70788A),
                      )),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Center(
                              child: Text('Hostel',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)),
                            ),
                            Center(
                              child: Text(hostel.toUpperCase(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Center(
                              child: Text('Room No',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)),
                            ),
                            Center(
                              child: Text(roomNum,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onBackground)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Caretaker',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                          Text('Mr Ram Prakash',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground)),
                        ],
                      ),
                      const Spacer(),
                      Center(
                          child: IconButton(
                              icon: Icon(Icons.call),
                              onPressed:(){ setState(() {
                                _launchCaller();
                              }); }
                          )),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Warden',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                          Text('Dr. Bhupendra Jogi',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground)),
                        ],
                      ),
                      Spacer(),
                      Center(
                          child: IconButton(
                            icon: Icon(Icons.call),
                            onPressed:(){ setState(() {
                              _launchCaller();
                            }); }
                          )),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
      //bottomNavigationBar: gnav(),
    );
  }
}
