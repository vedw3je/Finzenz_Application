// lib/di/di.dart

import 'package:finzenz_app/modules/home/bloc/home_cubit.dart';
import 'package:finzenz_app/modules/home/repository/account_repository.dart';
import 'package:finzenz_app/modules/home/repository/budget_repository.dart';
import 'package:finzenz_app/modules/home/repository/loan_repository.dart';
import 'package:finzenz_app/modules/home/repository/transaction_repo.dart';
import 'package:finzenz_app/modules/login/bloc/login_cubit.dart';
import 'package:finzenz_app/modules/login/repository/login_repo.dart';
import 'package:finzenz_app/modules/register/bloc/register_cubit.dart';
import 'package:finzenz_app/modules/register/repository/register_repo.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setupLocator() {
  // Register Cubits as singletons
  sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit(RegisterRepo()));
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit(LoginRepo()));
  sl.registerLazySingleton<HomeCubit>(
    () => HomeCubit(
      transactionRepository: TransactionRepository(),
      accountRepository: AccountRepository(),
      budgetRepository: BudgetRepository(),
      loanRepository: LoanRepository(),
    ),
  );
}
