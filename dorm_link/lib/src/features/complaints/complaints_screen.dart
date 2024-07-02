import 'package:dorm_link/src/Common_widgets/customappbar.dart';
import 'package:dorm_link/src/features/complaints/complaint_card.dart';
import 'package:dorm_link/src/features/complaints/new_complaint.dart';
import 'package:dorm_link/src/provider/closed_tickets_provider.dart';
import 'package:dorm_link/src/provider/open_tickets_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'complaints_list.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorm_link/src/features/auth/register.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'complaints_list.dart';

class Complaints extends ConsumerStatefulWidget {
  const Complaints({super.key, required this.token});

  final String token;

  @override
  ConsumerState<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends ConsumerState<Complaints> {
  late Future<void> _resolvedFuture, _unresolvedFuture;

  @override
  void initState() {
    _unresolvedFuture =
        ref.read(openTicketsProvider.notifier).fetchOpenTickets(widget.token);
    _resolvedFuture = ref
        .read(closedTicketsProvider.notifier)
        .fetchClosedTickets(widget.token);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final unresolved = ref.watch(openTicketsProvider);
    final resolved = ref.watch(closedTicketsProvider);
    ref.watch(closedTicketsProvider);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 250, 255),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 80,
            ),
            CustomAppBar(title: "Complaints"),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 16),
                          child: Text(
                            "Ongoing Tickets",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                        ),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const ShapeDecoration(
                              shape: OvalBorder(), color: Color(0xFFC1DCFB)),
                          child: Center(
                            child: Text(
                              '${unresolved.length}',
                              style: const TextStyle(
                                color: Color(0xFF539CF3),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: _unresolvedFuture,
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: unresolved.length,
                                itemBuilder: (context, index) {
                                  return ComplaintCard(
                                    heading: unresolved[index].title,
                                    description: unresolved[index].description,
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0, top: 18),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 16),
                          child: Text(
                            "Resolved Tickets",
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          ),
                        ),
                        Container(
                          width: 24,
                          height: 24,
                          decoration: const ShapeDecoration(
                              shape: OvalBorder(), color: Color(0xFFC1DCFB)),
                          child: Center(
                            child: Text(
                              '${resolved.length}',
                              style: const TextStyle(
                                color: Color(0xFF539CF3),
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w600,
                                height: 0,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  FutureBuilder(
                    future: _resolvedFuture,
                    builder: (context, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ListView.builder(
                                shrinkWrap: true,
                                itemCount: resolved.length,
                                itemBuilder: (context, index) {
                                  return ComplaintCard(
                                    heading: resolved[index].title,
                                    description: resolved[index].description,
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewComplaint(),
                ),

              );
            });
          },
          child: Icon(Icons.add)),
    );
  }
}
