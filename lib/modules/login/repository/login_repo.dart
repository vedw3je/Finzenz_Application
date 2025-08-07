import 'dart:convert';
import 'dart:developer';

import '../../home/model/user_model.dart';
import 'package:http/http.dart' as http;

class LoginRepo {
  Future<User?> loginUser(String email, String password) async {
    final url = Uri.parse('http://10.0.2.2:8080/api/users/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }
}
