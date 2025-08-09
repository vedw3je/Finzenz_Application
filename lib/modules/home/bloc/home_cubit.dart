import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/transaction_model.dart';
import '../repository/transaction_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TransactionRepository transactionRepository;

  HomeCubit({required this.transactionRepository}) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      // Fetch all in parallel
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
        ),
      );
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
