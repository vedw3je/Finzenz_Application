import '../model/transaction_model.dart';

final List<Transaction> transactions = [
  Transaction(
    id: 1,
    accountId: 101,
    amount: 250.75,
    transactionDate: DateTime.now(),
    description: "Grocery shopping with bae",
    transactionType: "DEBIT",
    category: "Groceries",
  ),
  Transaction(
    id: 2,
    accountId: 101,
    amount: 1200.00,
    transactionDate: DateTime.now().subtract(Duration(days: 1)),
    description: "Salary Credit",
    transactionType: "CREDIT",
    category: "Income",
  ),
  Transaction(
    id: 3,
    accountId: 101,
    amount: 85.50,
    transactionDate: DateTime.now().subtract(Duration(days: 3)),
    description: "Netflix Subscription",
    transactionType: "DEBIT",
    category: "Entertainment",
  ),
];
