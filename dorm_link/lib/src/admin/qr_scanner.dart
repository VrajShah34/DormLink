import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:dorm_link/src/features/auth/register.dart';

class QRCodeScanner extends StatefulWidget {
  const QRCodeScanner({super.key, required this.token});

  final String token;

  @override
  State<QRCodeScanner> createState() => _QRCodeScannerState();
}

class _QRCodeScannerState extends State<QRCodeScanner> {
  String barcode = 'Tap to Scan QR Code';

  String getMealType() {
    var now = DateTime.now();
    if (now.hour < 11) {
      return "Breakfast";
    } else if (now.hour < 16) {
      return "Lunch";
    } else {
      return "Dinner";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Scanner'),
      ),
      body: Center(
          child: AiBarcodeScanner(
        onScan: (String value) async {
          debugPrint(value);
          final messUrl = Uri.parse("$baseUrl/attendance");
          http.Response response = await http.post(
            messUrl,
            body: jsonEncode({
              'date': DateTime.now(),
              'mealType': getMealType(),
              'attendees': value.substring(0, 10)
            }),
            headers: {
              'Content-type': 'application/json',
              'Accept': 'application/json',
              'authorization': widget.token
            },
          );
          print(response.statusCode.toString());
          setState(() {
            barcode = value;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              "Attendance marked for ${barcode.substring(0, 10)}",
              style: TextStyle(color: Colors.white),
            )));
          });
        },
        onDetect: (p0) {},
      )),
    );
  }
}
