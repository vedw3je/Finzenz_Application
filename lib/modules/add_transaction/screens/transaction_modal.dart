import 'dart:developer';
import 'dart:ui';
import 'package:finzenz_app/commonwidgets/alert_box.dart';
import 'package:finzenz_app/commonwidgets/textfieldwidget.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/account_selector.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/category_selector.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/date_picker_field.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/transaction_submit_button.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/transaction_type_selector.dart';
import 'package:finzenz_app/modules/home/bloc/home_cubit.dart';
import 'package:finzenz_app/modules/home/bloc/home_state.dart';
import 'package:finzenz_app/modules/home/helpers/category_icon_mappers.dart';
import 'package:finzenz_app/modules/home/model/account_model.dart';
import 'package:finzenz_app/modules/home/repository/transaction_repo.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionModal extends StatefulWidget {
  const TransactionModal({super.key, required this.parentContext});

  final BuildContext parentContext;

  @override
  State<TransactionModal> createState() => _TransactionModalState();
}

class _TransactionModalState extends State<TransactionModal> {
  int? selectedAccountIndex;
  int? selectedCategoryIndex;
  int? selectedTransactionTypeIndex;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final dateController = TextEditingController();
  DateTime? selectedDate;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        List<Account> accounts = [];

        if (state is HomeFetched && state.accounts != null) {
          accounts = state.accounts;
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
                child: Form(
                  key: formKey,
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
                          setState(() {
                            selectedCategoryIndex = index;
                          });
                        },
                      ),

                      const SizedBox(height: 16),

                      TransactionTypeSelector(
                        selectedIndex: selectedTransactionTypeIndex,
                        onSelected: (index) {
                          setState(() => selectedTransactionTypeIndex = index);
                        },
                      ),
                      const SizedBox(height: 16),

                      /// Amount Field
                      AppTextFormField(
                        label: "Amount",
                        hintText: "Enter amount",
                        keyboardType: TextInputType.number,
                        controller: _amountController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter an amount";
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: 12),

                      /// Description Field
                      AppTextFormField(
                        label: "Description",
                        hintText: "Optional description",
                        controller: _descriptionController,
                      ),

                      const SizedBox(height: 20),

                      /// Date Picker Field
                      DatePickerField(
                        label: "Select Date",
                        controller: dateController,
                        initialDate: selectedDate,
                        onDateSelected: (pickedDate) {
                          setState(() {
                            selectedDate =
                                pickedDate; // update local selectedDate
                            dateController.text = DateFormat('yyyy-MM-dd')
                                .format(
                                  pickedDate,
                                ); // optional: keep controller synced
                          });
                          print("Selected date: $pickedDate");
                        },
                      ),
                      const SizedBox(height: 20),

                      /// Submit Button
                      TransactionSubmitButton(
                        onTap: () async {
                          log(
                            CategoryIconMapper.getCategories()[selectedAccountIndex! +
                                1],
                          );
                          if (selectedAccountIndex == null) {
                            showDialog(
                              context: widget.parentContext,
                              builder: (context) => FinzenzAlert(
                                title: "Select Account",
                                body:
                                    "Please select an account to add Transaction!",
                              ),
                            );

                            return;
                          }

                          if (selectedCategoryIndex == null) {
                            showDialog(
                              context: widget.parentContext,
                              builder: (context) => FinzenzAlert(
                                title: "Select Category",
                                body:
                                    "Please select the category of transaction!",
                              ),
                            );
                            return;
                          }
                          if (selectedTransactionTypeIndex == null) {
                            showDialog(
                              context: widget.parentContext,
                              builder: (context) => FinzenzAlert(
                                title: "Select Type",
                                body:
                                    "Please select the type of transaction made!",
                              ),
                            );
                            return;
                          }

                          if (formKey.currentState!.validate()) {
                            final transactionType =
                                TransactionTypeSelector.getTypeName(
                                  selectedTransactionTypeIndex!,
                                );
                            final selectedCategoryName =
                                CategoryIconMapper.getCategories()[selectedCategoryIndex!];
                            final selectedAccount =
                                accounts[selectedAccountIndex!];
                            log(selectedCategoryName);
                            final success = await TransactionRepository()
                                .saveTransaction(
                                  accountId: selectedAccount.id,
                                  amount: double.tryParse(
                                    _amountController.text,
                                  )!,
                                  transactionDate:
                                      selectedDate!, // pass it directly here
                                  description: _descriptionController.text,
                                  transactionType: transactionType,
                                  category: selectedCategoryName,
                                );
                            if (success) {
                              await showDialog(
                                context: widget.parentContext,
                                builder: (context) => FinzenzAlert(
                                  title: "Save Success",
                                  body:
                                      "Your transaction is saved successfully!",
                                ),
                              );
                              cubit.fetchHomeData();

                              Navigator.pop(context);
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
