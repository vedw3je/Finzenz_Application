import 'package:finzenz_app/modules/home/repository/account_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/transaction_model.dart';
import '../repository/transaction_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TransactionRepository transactionRepository;
  final AccountRepository accountRepository;

  HomeCubit({
    required this.transactionRepository,
    required this.accountRepository,
  }) : super(HomeInitial());

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
        ),
      );

      await fetchAccounts();
    } catch (e) {
      emit(HomeError(message: "Could not load transactions at the moment"));
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
}
