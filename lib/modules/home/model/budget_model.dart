class Budget {
  final int? id; // Optional if backend auto-generates
  final int userId;
  final String category;
  final double amount;
  final DateTime startDate;
  final DateTime endDate;

  Budget({
    this.id,
    required this.userId,
    required this.category,
    required this.amount,
    required this.startDate,
    required this.endDate,
  });

  factory Budget.fromJson(Map<String, dynamic> json) {
    return Budget(
      id: json['id'],
      userId: json['userId'],
      category: json['category'],
      amount: (json['amount'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'userId': userId,
      'category': category,
      'amount': amount,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }
}
