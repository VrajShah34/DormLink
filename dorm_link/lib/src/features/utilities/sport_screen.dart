import 'package:dorm_link/src/Common_widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:dorm_link/src/features/auth/register.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math' as math;

class SportsScreen extends StatefulWidget {
  const SportsScreen(
      {super.key,
      required this.sportName,
      required this.token,
      required this.numOfPlayers});

  final String sportName;
  final String token;
  final int numOfPlayers;

  @override
  State<SportsScreen> createState() => _SportsScreenState();
}

class _SportsScreenState extends State<SportsScreen> {
  var studentName = "";
  var enrollmentNo = "";

  @override
  void initState() {
    _fetchPersonDetails();
    super.initState();
  }
  void _fetchPersonDetails() async {
    final sportsUrl =
        Uri.parse("$baseUrl/sports/playing/${widget.sportName}");
    http.Response response = await http.get(
      sportsUrl,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': widget.token
      },
    );
    print(response.body);
    var json = jsonDecode(response.body);
    setState(() {

    studentName = json["name"];
    enrollmentNo = json["enrollmentNo"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        CustomAppBar(title: widget.sportName),
        SafeArea(
          minimum: EdgeInsets.all(20),
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: widget.numOfPlayers,
            itemBuilder: (ctx, index) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 6.0),
              child: ListTile(
                tileColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                leading: Initicon(
                  text: studentName,
                  backgroundColor:
                      Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
                          .withOpacity(1.0),
                  size: 32,
                ),
                title: Text(
                  "Name",
                  style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  enrollmentNo,
                  style: GoogleFonts.inter(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
            ),
          ),
        )
      ]),
    );
  }
}
