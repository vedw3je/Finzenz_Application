import 'dart:convert';
import 'package:finzenz_app/globals.dart';
import 'package:finzenz_app/modules/home/model/budget_model.dart';
import 'package:finzenz_app/prefservice.dart';
import 'package:http/http.dart' as http;

class BudgetRepository {
  Future<List<Budget>> fetchBudgetsForUser() async {
    final user = await PrefService.getUser();
    final userId = user!.id;

    final url = Uri.parse("$baseUrl/api/budgets/user/$userId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Budget.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch budgets: ${response.statusCode}");
    }
  }

  Future<bool> saveBudget({
    required String category,
    required double amount,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final user = await PrefService.getUser();
      final userId = user!.id;

      final url = Uri.parse('$baseUrl/api/budgets');

      final body = {
        "userId": userId,
        "category": category,
        "amount": amount,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Error creating budget: $e");
      return false;
    }
  }
}
