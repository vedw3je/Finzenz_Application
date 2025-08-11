import 'dart:convert';
import 'dart:developer';
import 'package:finzenz_app/prefservice.dart';
import 'package:http/http.dart' as http;

import '../model/transaction_model.dart';

class TransactionRepository {
  final String baseUrl = "http://10.0.2.2:8081";

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

  Future<double> getExpenseForUser() async {
    final user = await PrefService.getUser();

    if (user == null) {
      throw Exception("No logged-in user found.");
    }

    final url = Uri.parse('$baseUrl/api/transactions/user/${user.id}/expense');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return double.tryParse(response.body) ?? 0.0;
    } else {
      throw Exception('Failed to load expense');
    }
  }

  Future<double> getIncomeForUser() async {
    final user = await PrefService.getUser();

    if (user == null) {
      throw Exception("No logged-in user found.");
    }

    final url = Uri.parse('$baseUrl/api/transactions/user/${user.id}/income');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return double.tryParse(response.body) ?? 0.0;
    } else {
      throw Exception('Failed to load income');
    }
  }

  Future<bool> saveTransaction({
    required int accountId,
    required double amount,
    required DateTime transactionDate,
    required String description,
    required String transactionType,
    required String category,
  }) async {
    try {
      final url = Uri.parse('$baseUrl/api/transactions');

      final body = {
        "accountId": accountId,
        "amount": amount,
        "transactionDate": transactionDate.toIso8601String(),
        "description": description,
        "transactionType": transactionType,
        "category": category,
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Error saving transaction: $e");
      return false;
    }
  }
}
