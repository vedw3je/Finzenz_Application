import 'package:finzenz_app/commonwidgets/textfieldwidget.dart';
import 'package:finzenz_app/modules/login/bloc/login_cubit.dart';
import 'package:finzenz_app/modules/login/bloc/login_state.dart';
import 'package:finzenz_app/modules/register/screen/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginCubit = context.read<LoginCubit>();
    final navy = Colors.indigo[900]!;

    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(const SnackBar(content: Text("Login successful")));
            // TODO: Navigate to dashboard
          } else if (state is LoginError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: loginCubit.formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/animations/financeguru.json',
                      width: 250,
                      height: 250,
                      repeat: true,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Login to Finzenz to continue",
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 32),

                    AppTextFormField(
                      label: 'Email',
                      hintText: 'you@example.com',
                      keyboardType: TextInputType.emailAddress,
                      controller: loginCubit.emailController,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your email' : null,
                    ),
                    const SizedBox(height: 20),

                    AppTextFormField(
                      label: 'Password',
                      hintText: '••••••••',
                      obscureText: true,
                      controller: loginCubit.passwordController,
                      validator: (value) =>
                          value!.isEmpty ? 'Please enter your password' : null,
                    ),
                    const SizedBox(height: 32),

                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        return SizedBox(
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
                              if (loginCubit.formkey.currentState!.validate()) {
                                loginCubit.login();
                              }
                            },
                            child: state is LoginLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  )
                                : const Text(
                                    'Login',
                                    style: TextStyle(fontSize: 16),
                                  ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => RegisterScreen()),
                        );
                      },
                      child: const Text(
                        "No account yet? Register",
                        style: TextStyle(
                          color: Colors.grey,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
