import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math';

class QRCodePage extends StatefulWidget {
  const QRCodePage({super.key});

  @override
  State<QRCodePage> createState() => _QRCodePageState();
}

class _QRCodePageState extends State<QRCodePage> {

  var enrollmentNo = "";
  var hostel = "";

  @override
  void initState(){
    _loadData();
    super.initState();
  }

  void _loadData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      enrollmentNo = preferences.getString("enrollmentNo") ?? '';
      hostel = preferences.getString("hostel") ?? '';
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            QrImageView(
              data: "$enrollmentNo $hostel ${Random().nextInt(100000000000)+100000}",
              size: MediaQuery.of(context).size.width,
            ),
            Text(
              "Enrollment Number: $enrollmentNo",
              style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold),
            ),
            Text(
              "Hostel: ${hostel.toUpperCase()}",
              style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16,),
            Text(
              "Show the QR to the Mess Manager to avail your meal",
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.onBackground),
            ),
          ],
        ),
      ),
    );
  }
}
