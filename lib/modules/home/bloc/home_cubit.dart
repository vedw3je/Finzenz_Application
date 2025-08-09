// home_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/transaction_repo.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final TransactionRepository transactionRepository;

  HomeCubit({required this.transactionRepository}) : super(HomeInitial());

  Future<void> fetchHomeData() async {
    emit(HomeLoading());
    try {
      final transactions = await transactionRepository.getTransactionsByUser();
      emit(HomeFetched(transactions: transactions));
    } catch (e) {
      emit(HomeError(message: e.toString()));
    }
  }
}
