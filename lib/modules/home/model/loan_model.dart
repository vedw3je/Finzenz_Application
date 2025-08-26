class Loan {
  final int? id; // Optional if backend auto-generates
  final int accountId;
  final String lenderName;
  final double principalAmount;
  final double interestRate;
  final int? tenureMonths; // Nullable
  final double emiAmount;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime? nextDueDate;
  final String status; // ACTIVE, CLOSED, DEFAULTED
  final int recurringIntervalDays;
  final DateTime? lastPaymentDate;
  final int totalInstallments;
  final int completedInstallments;
  final DateTime createdAt;

  Loan({
    this.id,
    required this.accountId,
    required this.lenderName,
    required this.principalAmount,
    required this.interestRate,
    this.tenureMonths,
    required this.emiAmount,
    required this.startDate,
    required this.endDate,
    this.nextDueDate,
    required this.status,
    required this.recurringIntervalDays,
    this.lastPaymentDate,
    required this.totalInstallments,
    this.completedInstallments = 0,
    required this.createdAt,
  });

  factory Loan.fromJson(Map<String, dynamic> json) {
    return Loan(
      id: json['id'],
      accountId: json['accountId'],
      lenderName: json['lenderName'],
      principalAmount: (json['principalAmount'] as num).toDouble(),
      interestRate: (json['interestRate'] as num).toDouble(),
      tenureMonths: json['tenureMonths'],
      emiAmount: (json['emiAmount'] as num).toDouble(),
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      nextDueDate: json['nextDueDate'] != null
          ? DateTime.parse(json['nextDueDate'])
          : null,
      status: json['status'],
      recurringIntervalDays: json['recurringIntervalDays'],
      lastPaymentDate: json['lastPaymentDate'] != null
          ? DateTime.parse(json['lastPaymentDate'])
          : null,
      totalInstallments: json['totalInstallments'],
      completedInstallments: json['completedInstallments'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (id != null) 'id': id,
      'accountId': accountId,
      'lenderName': lenderName,
      'principalAmount': principalAmount,
      'interestRate': interestRate,
      if (tenureMonths != null) 'tenureMonths': tenureMonths,
      'emiAmount': emiAmount,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      if (nextDueDate != null) 'nextDueDate': nextDueDate!.toIso8601String(),
      'status': status,
      'recurringIntervalDays': recurringIntervalDays,
      if (lastPaymentDate != null)
        'lastPaymentDate': lastPaymentDate!.toIso8601String(),
      'totalInstallments': totalInstallments,
      'completedInstallments': completedInstallments,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
