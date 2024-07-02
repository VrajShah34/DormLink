import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dorm_link/src/features/auth/register.dart';
import 'package:dorm_link/src/models/ticket.dart';

class ClosedTicketsProvider extends StateNotifier<List<dynamic>> {
  ClosedTicketsProvider() : super([]);

  Future<void> fetchClosedTickets(String? token) async {
    if (token == null) {
      print("no token");
      return;
    }
    final ticketsUrl = Uri.parse("$baseUrl/tickets/get-cl-ticket");
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
final closedTicketsProvider =
    StateNotifierProvider<ClosedTicketsProvider, List<dynamic>>(
        (ref) => ClosedTicketsProvider());

