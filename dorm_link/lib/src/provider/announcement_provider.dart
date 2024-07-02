import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:dorm_link/src/features/auth/register.dart';
import 'dart:convert';

class AnnouncementsNotifier extends StateNotifier<List<dynamic>> {
  AnnouncementsNotifier() : super([]);

  Future<void> fetchAnnouncements(String? token) async {
    if (token == null) {
      print("no token");
      return;
    }
    final announcementUrl = Uri.parse("$baseUrl/announcements");
    http.Response response = await http.get(
      announcementUrl,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': token
      },
    );
    //print(response.body);
    final announcementsList = [];
    var json = jsonDecode(response.body);
    for (int i = 0; i < json.length; ++i) {
      print(json[i]["title"]);
      announcementsList.add([json[i]["title"], json[i]["createdBy"], json[i]["updatedAt"]]);
    }
    state = announcementsList;

  }
}

final announcementsProvider =
    StateNotifierProvider<AnnouncementsNotifier, List<dynamic>>(
        (ref) => AnnouncementsNotifier());
