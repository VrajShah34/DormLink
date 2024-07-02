import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorm_link/src/features/auth/register.dart';
import 'package:dorm_link/src/models/ticket.dart';
import 'package:shared_preferences/shared_preferences.dart';
class OpenTicketsProvider extends StateNotifier<List<dynamic>> {
  OpenTicketsProvider() : super([]);

  void addTicket(Ticket ticket) async {
    // var token = '';
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // token = preferences.getString("token") ?? '';
    // final messUrl = Uri.parse("$baseUrl/tickets/create-ticket");
    // http.Response response = await http.post(messUrl,
    //     headers: {
    //       'Content-type': 'application/json',
    //       'Accept': 'application/json',
    //       'authorization': token
    //     },
    //     body: jsonEncode({
    //       'title': subjectController.text,
    //       'description': messageController.text,
    //       'category' : selectedValue
    //     }));
    // print(response.statusCode);
    // var json = jsonDecode(response.body);
    // print(json);
    state = [ticket, ...state];
  }

  Future<void> fetchOpenTickets(String? token) async {
    if (token == null) {
      print("no token");
      return;
    }
    final ticketsUrl = Uri.parse("$baseUrl/tickets/get-op-ticket");
    http.Response response = await http.get(
      ticketsUrl,
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'authorization': token
      },
    );
    final allTickets = [];
    final json = jsonDecode(response.body);
    print(json);

    for (int i = 0; i < json.length; i++) {
      allTickets.add(Ticket.fromJson(json[i]));
    }
    state = allTickets;
  }
}
final openTicketsProvider =
    StateNotifierProvider<OpenTicketsProvider, List<dynamic>>(
        (ref) => OpenTicketsProvider());
