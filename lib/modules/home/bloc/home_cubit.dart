import 'package:finzenz_app/modules/home/model/user_model.dart';
import 'package:finzenz_app/modules/home/repository/account_repository.dart';
import 'package:finzenz_app/modules/home/repository/budget_repository.dart';
import 'package:finzenz_app/modules/home/repository/loan_repository.dart';
import 'package:finzenz_app/prefservice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/transaction_model.dart';
import '../model/loan_model.dart';
import '../repository/transaction_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TransactionRepository transactionRepository;
  final AccountRepository accountRepository;
  final BudgetRepository budgetRepository;
  final LoanRepository loanRepository;

  HomeCubit({
    required this.transactionRepository,
    required this.accountRepository,
    required this.budgetRepository,
    required this.loanRepository,
  }) : super(HomeInitial());

  User? user;

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final results = await Future.wait([
        transactionRepository.getTransactionsByUser(),
        transactionRepository.getIncomeForUser(),
        transactionRepository.getExpenseForUser(),
      ]);

      final transactions = results[0] as List<Transaction>;
      final totalIncome = results[1] as double;
      final totalExpense = results[2] as double;

      emit(
        HomeFetched(
          transactions: transactions,
          totalIncome: totalIncome,
          totalExpense: totalExpense,
          accounts: [],
          budgets: [],
          loans: [],
        ),
      );

      await fetchAccounts();
      await fetchBudgets();
      await fetchLoans();
    } catch (e) {
      emit(HomeError(message: "Could not load home data at the moment"));
    }
  }

  Future<void> fetchAccounts() async {
    try {
      final accounts = await accountRepository.fetchAccountsForUser();

      if (state is HomeFetched) {
        emit((state as HomeFetched).copyWith(accounts: accounts));
      }
    } catch (e) {
      // Optional: handle account fetch error separately
    }
  }

  Future<void> fetchBudgets() async {
    try {
      final budgets = await budgetRepository.fetchBudgetsForUser();

      if (state is HomeFetched) {
        emit((state as HomeFetched).copyWith(budgets: budgets));
      }
    } catch (e) {
      // Optional: handle budgets fetch error separately
    }
  }

  Future<void> fetchLoans() async {
    try {
      final loans = await loanRepository.fetchLoansForUser();

      if (state is HomeFetched) {
        emit((state as HomeFetched).copyWith(loans: loans));
      }
    } catch (e) {
      // Optional: handle loans fetch error separately
    }
  }

  void getUserDetails() async {
    final user = PrefService.getUser();
    this.user = await user;
  }
}
