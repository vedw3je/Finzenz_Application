import 'dart:developer';

import 'package:finzenz_app/modules/login/repository/login_repo.dart';
import 'package:finzenz_app/prefservice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.loginRepo) : super(LoginInitial());

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();
  final LoginRepo loginRepo;

  void login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      emit(const LoginError("Please enter both email and password"));
      return;
    }

    emit(LoginLoading());

    try {
      final user = await loginRepo.loginUser(email, password);

      if (user != null) {
        log(user.fullName);
        await PrefService.saveUser(user);
        emit(LoginSuccess(user: user));
      } else {
        emit(const LoginError("Invalid credentials"));
      }
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
