import 'package:dorm_link/src/Common_widgets/custombigbutton.dart';
import 'package:dorm_link/src/Common_widgets/customtextfield.dart';
import 'package:dorm_link/src/admin/mess_form.dart';
import 'package:dorm_link/src/admin/qr_scanner.dart';
import 'package:dorm_link/src/features/homepage/menu_box.dart';
import 'package:dorm_link/src/features/homepage/quick_actions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dorm_link/src/features/auth/login.dart';
class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key, required this.token});

  final String token;

  @override
  Widget build(BuildContext context) {
    void logOut() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.clear();
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => LoginPage()));
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(onPressed: () {logOut();}, icon: Icon(Icons.logout_outlined))
        ],
      ),
      body: SafeArea(
        //minimum: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Admin Dashboard',
                style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.onBackground),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            MenuBox(token: token),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                children: [
                  Expanded(
                    child: QuickActionsTile(
                      icon: Icons.qr_code_scanner_outlined,
                      text: "Scan QR Code",
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) => QRCodeScanner(
                                  token: token,
                                )));
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: QuickActionsTile(
                        icon: Icons.add_comment_outlined,
                        text: "Add Menu",
                        onTap: () {

                          showModalBottomSheet(
                            useSafeArea: true,
                            isScrollControlled: true,
                            context: context,
                            builder: (ctx) => MessForm()
                          );
                        }),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: QuickActionsTile(
                      icon: Icons.edit_note_outlined,
                      text: "Edit Menu",
                        onTap: () {

                          showModalBottomSheet(
                              useSafeArea: true,
                              isScrollControlled: true,
                              context: context,
                              builder: (ctx) => MessForm()
                          );
                        }
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
