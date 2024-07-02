import 'package:dorm_link/src/Common_widgets/customappbar.dart';
import 'package:dorm_link/src/Common_widgets/custombigbutton.dart';
import 'package:dorm_link/src/features/utilities/currently_playing.dart';
import 'package:dorm_link/src/features/utilities/now_playing_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dorm_link/src/features/auth/register.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';

class now_playing extends StatefulWidget {
  const now_playing({super.key, required this.token});

  final String token;

  @override
  State<now_playing> createState() => _now_playingState();
}

class _now_playingState extends State<now_playing> {
  int numOfPlayersBadminton = 0;
  int numOfPlayersFootball = 0;
  int numOfPlayersCricket = 0;
  int numOfPlayersTT = 0;
  bool isPlaying = false;
  String currentSport = "";

  // void initState() {
  //   _fetchNumOfPlayers();
  //   super.initState();
  // }
  //
  // _fetchNumOfPlayers() async {
  //   final sportsUrl = Uri.parse("$baseUrl/sports/playing");
  //   http.Response response = await http.get(
  //     sportsUrl,
  //     headers: {
  //       'Content-type': 'application/json',
  //       'Accept': 'application/json',
  //       'authorization': widget.token
  //     },
  //   );
  //   var json = jsonDecode(response.body);
  //   print(json);
  // }

  void playSport(String sportsName) async {
    final sportsUrl = Uri.parse("$baseUrl/sports/addPlayer/$sportsName");
    http.Response response = await http.post(
      sportsUrl,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': widget.token
      },
    );
    print(response.statusCode.toString());
    setState(() {

    });
  }

  void stopPlaying(String sportName) async {
    final sportsUrl = Uri.parse("$baseUrl/sports/removePlayer/$sportName");
    http.Response response = await http.delete(
      sportsUrl,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': widget.token
      },
    );
    print(response.statusCode.toString());
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 250, 255),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppBar(title: "Now Playing"),
          SafeArea(
            minimum: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                        child: NowPlayingCard(
                      sportName: "Badminton",
                      token: widget.token,
                      //numOfPlayers: numOfPlayersBadminton,
                    )),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: NowPlayingCard(
                      sportName: "Table Tennis",
                      token: widget.token,
                      //numOfPlayers: numOfPlayersTT,
                    )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        child: NowPlayingCard(
                      sportName: "Cricket",
                      token: widget.token,
                      //numOfPlayers: numOfPlayersCricket,
                    )),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                        child: NowPlayingCard(
                      sportName: "Football",
                      token: widget.token,
                      //numOfPlayers: numOfPlayersFootball,
                    )),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          scrollable: true,
                          title: Center(
                              child: Text(
                            "Select Sport",
                            style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onBackground),
                          )),
                          content: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4),
                                child: CustomBigButton(
                                  onTap: () {
                                    setState(() {
                                      isPlaying = true;
                                      //numOfPlayersBadminton++;
                                      playSport("Badminton");
                                      Navigator.of(context).pop();
                                      currentSport = "Badminton";
                                    });
                                  },
                                  title: "Badminton",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4),
                                child: CustomBigButton(
                                  onTap: () {
                                    setState(() {
                                      playSport("Table Tennis");
                                      isPlaying = true;
                                      //numOfPlayersTT++;
                                      Navigator.of(context).pop();
                                    });
                                  },
                                  title: "Table Tennis",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4),
                                child: CustomBigButton(
                                  onTap: () {
                                    setState(() {
                                      isPlaying = true;
                                      numOfPlayersCricket++;
                                      Navigator.of(context).pop();
                                      currentSport = "Cricket";
                                    });
                                  },
                                  title: "Cricket",
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0, vertical: 4),
                                child: CustomBigButton(
                                  onTap: () {
                                    setState(() {
                                      isPlaying = true;
                                      numOfPlayersFootball++;
                                      Navigator.of(context).pop();
                                      currentSport = "Football";
                                    });
                                  },
                                  title: "Football",
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(14, 18, 18, 18),
                            spreadRadius: 2,
                            blurRadius: 10,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(isPlaying ? "Stop Playing" : "Start Playing",
                          style: GoogleFonts.inter(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //     onPressed: isPlaying
      //         ? () {
      //             setState(() {
      //               isPlaying = false;
      //               //initState();
      //             });
      //           }
      //         : () {
      //             showDialog(
      //               context: context,
      //               builder: (BuildContext context) {
      //                 return AlertDialog(
      //                   scrollable: true,
      //                   title: Center(
      //                       child: Text(
      //                     "Select Sport",
      //                     style: TextStyle(
      //                         color:
      //                             Theme.of(context).colorScheme.onBackground),
      //                   )),
      //                   content: Column(
      //                     children: [
      //                       Padding(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 16.0, vertical: 4),
      //                         child: CustomBigButton(
      //                           onTap: () {
      //                             setState(() {
      //                               isPlaying = true;
      //                               numOfPlayersBadminton++;
      //                               Navigator.of(context).pop();
      //                             });
      //                           },
      //                           title: "Badminton",
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 16.0, vertical: 4),
      //                         child: CustomBigButton(
      //                           onTap: () {
      //                             setState(() {
      //                               isPlaying = true;
      //                               numOfPlayersTT++;
      //                               Navigator.of(context).pop();
      //                             });
      //                           },
      //                           title: "Table Tennis",
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 16.0, vertical: 4),
      //                         child: CustomBigButton(
      //                           onTap: () {
      //                             setState(() {
      //                               isPlaying = true;
      //                               numOfPlayersCricket++;
      //                               Navigator.of(context).pop();
      //                             });
      //                           },
      //                           title: "Cricket",
      //                         ),
      //                       ),
      //                       Padding(
      //                         padding: const EdgeInsets.symmetric(
      //                             horizontal: 16.0, vertical: 4),
      //                         child: CustomBigButton(
      //                           onTap: () {
      //                             setState(() {
      //                               isPlaying = true;
      //                               numOfPlayersFootball++;
      //                               Navigator.of(context).pop();
      //                             });
      //                           },
      //                           title: "Football",
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                 );
      //               },
      //             );
      //           },
      //     child: isPlaying
      //         ? const Text("Stop Playing",
      //             style: TextStyle(color: Colors.white, fontSize: 12))
      //         : const Text("Start Playing",
      //             style: TextStyle(color: Colors.white, fontSize: 12))));
    );
  }
}
