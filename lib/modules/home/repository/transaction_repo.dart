import 'dart:convert';
import 'dart:developer';
import 'package:finzenz_app/prefservice.dart';
import 'package:http/http.dart' as http;

import '../model/transaction_model.dart';

class TransactionRepository {
  final String baseUrl = "http://10.0.2.2:8080";

  Future<List<Transaction>> getTransactionsByUser() async {
    final user = await PrefService.getUser();

    if (user == null) {
      throw Exception("No logged-in user found.");
    }

    final url = Uri.parse('$baseUrl/api/transactions/user/${user.id}');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      log(response.body);
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Transaction.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }
}
