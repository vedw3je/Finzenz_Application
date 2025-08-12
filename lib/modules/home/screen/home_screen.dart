import 'package:finzenz_app/commonwidgets/finzenzappbar.dart';
import 'package:finzenz_app/modules/home/bloc/home_cubit.dart';
import 'package:finzenz_app/modules/home/bloc/home_state.dart';
import 'package:finzenz_app/modules/home/widgets/IncomeExpense_card.dart';
import 'package:finzenz_app/modules/home/widgets/transaction_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final cubit = context.read<HomeCubit>();
    cubit.getUserDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: buildFinzenzAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeFetched) {
              if (state.transactions.isEmpty) {
                return Column(
                  children: [
                    IncomeExpenseCard(
                      expense: state.totalExpense,
                      income: state.totalIncome,
                    ),
                    const SizedBox(height: 20),
                    const Expanded(
                      child: Center(
                        child: Text(
                          "No transactions added. Lets Add transactions!",
                        ),
                      ),
                    ),
                  ],
                );
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IncomeExpenseCard(
                    expense: state.totalExpense,
                    income: state.totalIncome,
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.transactions.length,
                      itemBuilder: (context, index) {
                        final tx = state.transactions[index];
                        return TransactionCard(transaction: tx);
                      },
                    ),
                  ),
                ],
              );
            } else if (state is HomeError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
