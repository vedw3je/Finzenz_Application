import 'dart:convert';
import 'package:finzenz_app/prefservice.dart';
import 'package:http/http.dart' as http;
import 'package:finzenz_app/globals.dart';

import '../model/account_model.dart';

class AccountRepository {

  Future<List<Account>> fetchAccountsForUser() async {
    final user = await PrefService.getUser();
    final userId = user!.id;

    final url = Uri.parse("$baseUrl/api/accounts/user/$userId");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Account.fromJson(json)).toList();
    } else {
      throw Exception("Failed to fetch accounts: ${response.statusCode}");
    }
  }
}
