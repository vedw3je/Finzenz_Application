import 'dart:developer';

import 'package:finzenz_app/modules/register/repository/register_repo.dart';
import 'package:finzenz_app/prefservice.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final RegisterRepo registerRepo;
  RegisterCubit(this.registerRepo) : super(RegisterInitial());

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final dobController = TextEditingController();

  String gender = 'Male'; // default
  DateTime? dateOfBirth;

  void setGender(String value) {
    gender = value;
    emit(RegisterInitial());
  }

  void setDateOfBirth(DateTime date) {
    dateOfBirth = date;
    emit(RegisterInitial());
  }

  Future<void> registerUser() async {
    emit(RegisterLoading());

    try {
      final user = await registerRepo.registerUser(
        fullName: fullNameController.text.trim(),
        email: emailController.text.trim(),
        password: passwordController.text,
        phone: phoneController.text.trim(),
        address: addressController.text.trim(),
        gender: gender,
        dateOfBirth: dobController.text.trim(),
        isActive: true,
        kycVerified: false,
      );

      await PrefService.saveUser(user);
      emit(RegisterSuccess(user: user));
    } catch (e) {
      log(e.toString());
      emit(RegisterError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    addressController.dispose();
    return super.close();
  }
}
