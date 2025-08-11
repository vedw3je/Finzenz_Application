// home_state.dart
import 'package:finzenz_app/modules/home/model/account_model.dart';
import 'package:finzenz_app/modules/home/model/transaction_model.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeFetched extends HomeState {
  final List<Transaction> transactions;
  final double totalIncome;
  final double totalExpense;
  final List<Account> accounts;

  HomeFetched({
    required this.transactions,
    required this.totalIncome,
    required this.totalExpense,
    required this.accounts,
  });

  HomeFetched copyWith({
    List<Transaction>? transactions,
    double? totalIncome,
    double? totalExpense,
    List<Account>? accounts,
  }) {
    return HomeFetched(
      transactions: transactions ?? this.transactions,
      totalIncome: totalIncome ?? this.totalIncome,
      totalExpense: totalExpense ?? this.totalExpense,
      accounts: accounts ?? this.accounts,
    );
  }
}

class HomeError extends HomeState {
  final String message;
  HomeError({required this.message});
}
