import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

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
      // TODO: Replace with actual API logic
      await Future.delayed(const Duration(seconds: 2));

      // Example validation (replace with actual)
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        emit(RegisterError("Email and password cannot be empty"));
        return;
      }

      // All good
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError("Something went wrong"));
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
