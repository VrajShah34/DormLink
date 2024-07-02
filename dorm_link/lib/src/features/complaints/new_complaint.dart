import 'package:dorm_link/src/Common_widgets/custombigbutton.dart';
import 'package:dorm_link/src/features/complaints/complaints_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'complaints_list.dart';
import 'complaint_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dorm_link/src/features/auth/register.dart';

final subjectController = TextEditingController();
final messageController = TextEditingController();

class NewComplaint extends StatefulWidget {
  const NewComplaint({super.key});

  @override
  State<NewComplaint> createState() => _NewComplaintState();
}

class _NewComplaintState extends State<NewComplaint> {
  var selectedValue = '';

  @override
  void sendEmail() async {
    unresolved.add(ComplaintCard(
        heading: subjectController.text, description: messageController.text));
    var token = '';
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      token = preferences.getString("token") ?? '';
    });
    final messUrl = Uri.parse("$baseUrl/tickets/create-ticket");
    http.Response response = await http.post(messUrl,
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'authorization': token
        },
        body: jsonEncode({
          'title': subjectController.text,
          'description': messageController.text,
          'category' : selectedValue
        }));
    print(response.statusCode);
    var json = jsonDecode(response.body);
    print(json);
    Navigator.pop(context);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 55.0, bottom: 30),
                    child: Container(
                      alignment: Alignment.topLeft,
                      decoration: const BoxDecoration(
                        color: Color(0xFF4A9DFF),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(45),
                          bottomRight: Radius.circular(45),
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: 15.0, horizontal: 15),
                        child: Text(
                          'New Complaint',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(25, 14, 25, 0),
              child: Form(
                child: Column(
                  children: [
                    TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                      controller: subjectController,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.subject_rounded),
                        hintText: 'Subject',
                        labelText: 'Subject',
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    TextFormField(
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.onBackground),
                      controller: messageController,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.message),
                        hintText: 'Complaint',
                        labelText: 'Complaint',
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    DropdownButtonFormField(
                        hint: Text(
                          "Category",
                          style: TextStyle(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                        ),
                        items: [
                          DropdownMenuItem(
                              child: Text(
                                'Electric',
                                style: TextStyle(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                              ),
                              value: 'Electric'),
                          DropdownMenuItem(
                            child: Text(
                              'Carpenter',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                            value: 'Carpenter',
                          ),
                          DropdownMenuItem(
                            child: Text(
                              'Other',
                              style: TextStyle(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                            ),
                            value: 'Other',
                          ),
                        ],
                        onChanged: (value) {
                          if (value == null) return;
                          selectedValue = value;
                        }),
                    SizedBox(
                      height: 25,
                    ),
                    CustomBigButton(
                      onTap: sendEmail,
                      title: "Send",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
