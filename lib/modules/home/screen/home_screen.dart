import 'package:finzenz_app/commonwidgets/finzenzappbar.dart';
import 'package:finzenz_app/modules/home/bloc/home_cubit.dart';
import 'package:finzenz_app/modules/home/bloc/home_state.dart';
import 'package:flutter/material.dart';

import '../helpers/dummy_transactions.dart';
import '../model/transaction_model.dart';
import '../widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildFinzenzAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeFetched) {
              if (state.transactions.isEmpty) {
                return const Center(child: Text("No transactions found."));
              }
              return ListView.builder(
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  final tx = state.transactions[index];
                  return TransactionCard(transaction: tx);
                },
              );
            } else if (state is HomeError) {
              return Center(child: Text('Error: ${state.message}'));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
