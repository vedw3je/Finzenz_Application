import 'package:finzenz_app/modules/add_transaction/widgets/account_selector.dart';
import 'package:finzenz_app/modules/home/bloc/home_cubit.dart';
import 'package:finzenz_app/modules/home/bloc/home_state.dart';
import 'package:finzenz_app/modules/home/model/account_model.dart';
import 'package:finzenz_app/modules/home/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    int? selectedAccountIndex;

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();

        List<Account> accounts = [];

        if (state is HomeFetched && state.accounts != null) {
          accounts = state.accounts;
        }
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AccountSelector(
                  accounts: accounts,
                  selectedIndex: selectedAccountIndex,
                  onSelected: (index) {
                    setState(() => selectedAccountIndex = index);
                  },
                ),
                SizedBox(height: 20),

                Text(cubit.user!.fullName),
                Text(cubit.user!.address),
                Text(cubit.user!.gender),
                Text(cubit.user!.phone),
              ],
            ),
          ),
        );
      },
    );
  }
}
