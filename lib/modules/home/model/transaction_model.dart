class Transaction {
  final int id;
  final int accountId;
  final double amount;
  final DateTime transactionDate;
  final String description;
  final String transactionType;
  final String category;

  Transaction({
    required this.id,
    required this.accountId,
    required this.amount,
    required this.transactionDate,
    required this.description,
    required this.transactionType,
    required this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      accountId: json['accountId'],
      amount: (json['amount'] as num).toDouble(),
      transactionDate: DateTime.parse(json['transactionDate']),
      description: json['description'] ?? '',
      transactionType: json['transactionType'] ?? '',
      category: json['category'] ?? '',
    );
  }
}
