// lib/di/di.dart

import 'package:finzenz_app/modules/login/bloc/login_cubit.dart';
import 'package:finzenz_app/modules/login/repository/login_repo.dart';
import 'package:finzenz_app/modules/register/bloc/register_cubit.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void setupLocator() {
  // Register Cubits as singletons
  sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit());
  sl.registerLazySingleton<LoginCubit>(() => LoginCubit(LoginRepo()));
}
