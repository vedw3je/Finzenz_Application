import 'dart:convert';
import 'package:finzenz_app/globals.dart';
import 'package:finzenz_app/modules/home/model/loan_model.dart';
import 'package:finzenz_app/prefservice.dart';
import 'package:http/http.dart' as http;

class LoanRepository {
  Future<List<Loan>> fetchLoansForUser() async {
    final user = await PrefService.getUser();
    final userId = user!.id;

    final url = Uri.parse("$baseUrl/api/loans/user/$userId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Loan.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch loans: ${response.statusCode}");
    }
  }

  Future<bool> saveLoan({
    required String lenderName,
    required double principalAmount,
    required double interestRate,
    required double emiAmount,
    required DateTime startDate,
    required DateTime endDate,
    required int recurringIntervalDays,
    required int totalInstallments,
  }) async {
    try {
      final user = await PrefService.getUser();
      final userId = user!.id;

      final url = Uri.parse('$baseUrl/api/loans');

      final body = {
        "userId": userId,
        "lenderName": lenderName,
        "principalAmount": principalAmount,
        "interestRate": interestRate,
        "emiAmount": emiAmount,
        "startDate": startDate.toIso8601String(),
        "endDate": endDate.toIso8601String(),
        "recurringIntervalDays": recurringIntervalDays,
        "totalInstallments": totalInstallments,
      };

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(body),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (e) {
      print("Error creating loan: $e");
      return false;
    }
  }
}
