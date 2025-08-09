import 'package:finzenz_app/modules/home/model/transaction_model.dart';
import 'package:flutter/material.dart';

import '../helpers/category_icon_mappers.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.15),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(4, 6), // 3D shadow
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Icon(
          color: transaction.transactionType == "DEBIT"
              ? Colors.redAccent
              : Colors.green,

          CategoryIconMapper.getIcon(transaction.category),
        ),
        title: Text(
          transaction.description,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          "${transaction.category} • ${_formatDate(transaction.transactionDate)}",
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Text(
          "${transaction.transactionType == "DEBIT" ? "- " : "+ "}\$${transaction.amount.toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: transaction.transactionType == "DEBIT"
                ? Colors.redAccent
                : Colors.green,
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }
}
