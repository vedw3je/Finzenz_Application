import 'dart:convert';

class Account {
  final int id;
  final String accountName;
  final String accountType;
  final String institutionName;
  final String accountNumber;
  final double balance;
  final String currency;
  final bool isActive;
  final int userId;
  final String userEmail;

  Account({
    required this.id,
    required this.accountName,
    required this.accountType,
    required this.institutionName,
    required this.accountNumber,
    required this.balance,
    required this.currency,
    required this.isActive,
    required this.userId,
    required this.userEmail,
  });

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'] ?? 0,
      accountName: json['accountName'] ?? '',
      accountType: json['accountType'] ?? '',
      institutionName: json['institutionName'] ?? '',
      accountNumber: json['accountNumber'] ?? '',
      balance: (json['balance'] != null)
          ? double.tryParse(json['balance'].toString()) ?? 0.0
          : 0.0,
      currency: json['currency'] ?? '',
      isActive: json['isActive'] ?? false,
      userId: json['userId'] ?? 0,
      userEmail: json['userEmail'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'accountName': accountName,
      'accountType': accountType,
      'institutionName': institutionName,
      'accountNumber': accountNumber,
      'balance': balance,
      'currency': currency,
      'isActive': isActive,
      'userId': userId,
      'userEmail': userEmail,
    };
  }

  static Account fromJsonString(String source) =>
      Account.fromJson(json.decode(source));

  String toJsonString() => json.encode(toJson());
}
