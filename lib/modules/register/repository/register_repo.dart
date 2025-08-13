import 'dart:convert';
import 'dart:developer';
import 'package:finzenz_app/globals.dart';
import 'package:http/http.dart' as http;
import '../../home/model/user_model.dart';

class RegisterRepo {
  Future<User> registerUser({
    required String fullName,
    required String email,
    required String password,
    required String phone,
    required String address,
    required String gender,
    required String dateOfBirth, // format: YYYY-MM-DD
    required bool isActive,
    required bool kycVerified,
  }) async {
    final url = Uri.parse('$baseUrl/api/users/register');

    final body = {
      "fullName": fullName,
      "email": email,
      "password": password,
      "phone": phone,
      "address": address,
      "gender": gender,
      "dateOfBirth": dateOfBirth,
      "isActive": isActive,
      "kycVerified": kycVerified,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
    log(response.toString());

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('User registration failed: ${response.body}');
    }
  }
}
