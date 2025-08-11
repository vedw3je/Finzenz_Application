import 'dart:ui';
import 'package:finzenz_app/commonwidgets/textfieldwidget.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/account_selector.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/category_selector.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/transaction_submit_button.dart';
import 'package:finzenz_app/modules/home/bloc/home_cubit.dart';
import 'package:finzenz_app/modules/home/bloc/home_state.dart';
import 'package:finzenz_app/modules/home/helpers/category_icon_mappers.dart';
import 'package:finzenz_app/modules/home/model/account_model.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionModal extends StatefulWidget {
  const TransactionModal({super.key});

  @override
  State<TransactionModal> createState() => _TransactionModalState();
}

class _TransactionModalState extends State<TransactionModal> {
  int? selectedAccountIndex;
  int? selectedCategoryIndex;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        List<Account> accounts = [];

        if (state is HomeFetched && state.accounts != null) {
          accounts = state.accounts!;
        }

        return ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(24),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 20,
                    spreadRadius: 2,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /// Drag handle
                    Center(
                      child: Container(
                        width: 40,
                        height: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),

                    /// Title
                    Text(
                      "Add Transaction 💸",
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            letterSpacing: 1.2,
                            fontSize: 22,
                            color: const Color(0xFF0D1B2A),
                            shadows: [
                              Shadow(
                                offset: const Offset(1, 2),
                                blurRadius: 4,
                                color: Colors.black.withOpacity(0.15),
                              ),
                            ],
                            fontFamily: 'PlayfairDisplay',
                          ),
                    ),

                    const SizedBox(height: 16),

                    /// Account Selector
                    if (accounts.isNotEmpty)
                      AccountSelector(
                        accounts: accounts,
                        selectedIndex: selectedAccountIndex,
                        onSelected: (index) {
                          setState(() => selectedAccountIndex = index);
                        },
                      )
                    else
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircularProgressIndicator(),
                        ),
                      ),

                    const SizedBox(height: 16),

                    /// Category Selector
                    CategorySelector(
                      categories: CategoryIconMapper.getCategories(),
                      selectedIndex: selectedCategoryIndex,
                      onSelected: (index) {
                        setState(() => selectedCategoryIndex = index);
                      },
                    ),

                    const SizedBox(height: 16),

                    /// Amount Field
                    AppTextFormField(
                      label: "Amount",
                      hintText: "Enter amount",
                      keyboardType: TextInputType.number,
                      controller: _amountController,
                    ),

                    const SizedBox(height: 12),

                    /// Description Field
                    AppTextFormField(
                      label: "Description",
                      hintText: "Optional description",
                      controller: _descriptionController,
                    ),

                    const SizedBox(height: 20),

                    /// Submit Button
                    TransactionSubmitButton(
                      onTap: () {
                        // You can now use selectedAccountIndex to get the selected Account
                        if (selectedAccountIndex != null &&
                            selectedAccountIndex! < accounts.length) {
                          final selectedAccount =
                              accounts[selectedAccountIndex!];
                          print(
                            "Selected account: ${selectedAccount.accountName}",
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
