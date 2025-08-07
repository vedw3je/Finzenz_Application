import 'package:finzenz_app/modules/login/screen/login_screen.dart';
import 'package:finzenz_app/modules/register/bloc/register_cubit.dart';
import 'package:finzenz_app/modules/register/bloc/register_state.dart';
import 'package:finzenz_app/modules/register/widgets/custom_text_field.dart';
import 'package:finzenz_app/modules/register/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final navy = Colors.indigo[900]!;
    final cubit = context.read<RegisterCubit>();

    return Scaffold(
      body: BlocConsumer<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Registration Successful")),
            );
          } else if (state is RegisterError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text("Error: ${state.message}")));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  Lottie.asset(
                    'assets/animations/financeguru.json',
                    width: 250,
                    height: 250,
                    repeat: true,
                  ),
                  CustomTextField(
                    controller: cubit.fullNameController,
                    label: "Full Name",
                    hint: "John Doe",
                  ),

                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: cubit.emailController,
                    label: "Email",
                    hint: "you@example.com",
                    keyboardType: TextInputType.emailAddress,
                  ),

                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: cubit.passwordController,
                    label: "Password",
                    hint: "••••••••",
                    obscureText: true,
                  ),

                  const SizedBox(height: 16),

                  CustomTextField(
                    controller: cubit.phoneController,
                    label: "Phone",
                    hint: "+91XXXXXXXXXX",
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),
                  CustomTextField(
                    controller: cubit.addressController,
                    label: "Address",
                    hint: "123 Street, City",
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    value: cubit.gender,
                    decoration: _fieldDecoration("Gender"),
                    items: const [
                      DropdownMenuItem(value: "Male", child: Text("Male")),
                      DropdownMenuItem(value: "Female", child: Text("Female")),
                      DropdownMenuItem(value: "Other", child: Text("Other")),
                    ],
                    onChanged: (value) {
                      cubit.setGender(value!);
                    },
                    validator: (value) =>
                        value == null ? "Select gender" : null,
                  ),
                  const SizedBox(height: 16),
                  DatePickerTextField(controller: cubit.dobController),

                  const SizedBox(height: 24),
                  state is RegisterLoading
                      ? const Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: navy,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                cubit.registerUser();
                              }
                            },
                            child: state is RegisterLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  )
                                : const Text(
                                    'Register',
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),
                        ),

                  const SizedBox(height: 10),

                  Align(
                    alignment: Alignment.center,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Already Registered? Login here!",
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  InputDecoration _fieldDecoration(String label, [String? hint]) {
    return InputDecoration(
      filled: true,
      fillColor: const Color(0xFFF0F4F8), // Light bluish-grey
      labelText: label,
      hintText: hint,
      labelStyle: const TextStyle(color: Colors.black87),
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }
}
