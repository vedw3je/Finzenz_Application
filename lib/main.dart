import 'package:finzenz_app/di.dart';
import 'package:finzenz_app/modules/login/bloc/login_cubit.dart';
import 'package:finzenz_app/modules/register/bloc/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'modules/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  setupLocator(); // initialize dependency injection
  runApp(const FinzenzApp());
}

class FinzenzApp extends StatelessWidget {
  const FinzenzApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(create: (_) => sl<LoginCubit>()),
        BlocProvider<RegisterCubit>(create: (_) => sl<RegisterCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Finzenz',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.indigo[900],
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Colors.black),
            bodyMedium: TextStyle(color: Colors.black54),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
