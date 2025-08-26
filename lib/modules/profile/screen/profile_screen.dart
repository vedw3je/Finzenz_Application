import 'package:finzenz_app/constants/app_colors.dart';
import 'package:finzenz_app/modules/home/model/budget_model.dart';
import 'package:finzenz_app/modules/home/model/loan_model.dart';
import 'package:finzenz_app/modules/profile/widget/budget_list.dart';
import 'package:finzenz_app/modules/profile/widget/loan_list.dart';
import 'package:finzenz_app/modules/profile/widget/profile_card.dart';
import 'package:finzenz_app/modules/profile/widget/section_heading.dart';
import 'package:finzenz_app/modules/home/model/account_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../add_transaction/widgets/account_selector.dart';
import '../../home/bloc/home_cubit.dart';
import '../../home/bloc/home_state.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  int selectedAccountIndex = 0;
  int selectedLoanIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().fetchHomeData();
  }

  Widget _glassCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.4), width: 1.2),
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: BoxDecoration(gradient: AppColors.mainGradient),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          List<Account> accounts = [];
          List<Budget> budgets = [];
          List<Loan> loans = [];

          if (state is HomeFetched) {
            accounts = state.accounts;
            budgets = state.budgets;
            loans = state.loans;
          }

          return Stack(
            children: [
              // Background gradient layer
              Container(
                height: 180,
                decoration: BoxDecoration(gradient: AppColors.mainGradient),
              ),

              // Foreground content
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),
                    ProfileCard(),

                    // Accounts
                    _glassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeading(title: "Your Accounts"),
                          AccountSelector(
                            isProfile: true,
                            accounts: accounts,
                            selectedIndex: selectedAccountIndex,
                            onSelected: (index) {
                              setState(() {
                                selectedAccountIndex = index;
                              });
                            },
                          ),
                        ],
                      ),
                    ),

                    // Budgets
                    _glassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeading(title: "Your Budgets"),
                          budgets.isNotEmpty
                              ? BudgetList(
                                  isProfile: true,
                                  budgets: budgets,
                                  selectedIndex: selectedAccountIndex,
                                  onSelected: (index) {},
                                )
                              : const Text(
                                  "No budgets set yet. Start adding some!",
                                  style: TextStyle(color: Colors.grey),
                                ),
                        ],
                      ),
                    ),

                    // Loans
                    _glassCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SectionHeading(title: "Active Loans"),
                          loans.isNotEmpty
                              ? LoanList(
                                  isProfile: true,
                                  loans: loans,
                                  selectedIndex: selectedLoanIndex,
                                  onSelected: (index) {
                                    setState(() {
                                      selectedLoanIndex = index;
                                    });
                                  },
                                )
                              : const Text(
                                  "No active loans found.",
                                  style: TextStyle(color: Colors.grey),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
