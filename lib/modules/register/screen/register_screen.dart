import 'package:finzenz_app/modules/register/bloc/register_cubit.dart';
import 'package:finzenz_app/modules/register/bloc/register_state.dart';
import 'package:finzenz_app/modules/register/widgets/custom_text_field.dart';
import 'package:finzenz_app/modules/register/widgets/date_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();

    return Scaffold(
      appBar: AppBar(title: const Text("Register")),
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
                      : ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              cubit.registerUser();
                            }
                          },
                          child: const Text("Register"),
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
