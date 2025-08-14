import 'dart:ui';

import 'package:finzenz_app/commonwidgets/alert_box.dart';
import 'package:finzenz_app/commonwidgets/textfieldwidget.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/category_selector.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/date_picker_field.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/transaction_submit_button.dart';
import 'package:finzenz_app/modules/home/bloc/home_cubit.dart';
import 'package:finzenz_app/modules/home/helpers/category_icon_mappers.dart';
import 'package:finzenz_app/modules/home/repository/budget_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddBudgetModal extends StatefulWidget {
  const AddBudgetModal({super.key, required this.parentContext});

  final BuildContext parentContext;

  @override
  State<AddBudgetModal> createState() => _AddBudgetModalState();
}

class _AddBudgetModalState extends State<AddBudgetModal> {
  int? selectedCategoryIndex;
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  DateTime? startDate;
  DateTime? endDate;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
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
                    "Add Budget 📊",
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
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

                  /// Category Selector (reused widget)
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

                  /// Amount Field
                  AppTextFormField(
                    label: "Amount",
                    hintText: "Enter budget amount",
                    keyboardType: TextInputType.number,
                    controller: _amountController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter an amount";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  /// Start Date Picker
                  DatePickerField(
                    label: "Start Date",
                    controller: _startDateController,
                    initialDate: startDate,
                    onDateSelected: (pickedDate) {
                      setState(() {
                        startDate = pickedDate;
                        _startDateController.text = DateFormat(
                          'yyyy-MM-dd',
                        ).format(pickedDate);
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  /// End Date Picker
                  DatePickerField(
                    label: "End Date",
                    controller: _endDateController,
                    initialDate: endDate,
                    onDateSelected: (pickedDate) {
                      setState(() {
                        endDate = pickedDate;
                        _endDateController.text = DateFormat(
                          'yyyy-MM-dd',
                        ).format(pickedDate);
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  /// Submit Button
                  TransactionSubmitButton(
                    label: "Save Budget",
                    onTap: () async {
                      if (selectedCategoryIndex == null) {
                        showDialog(
                          context: widget.parentContext,
                          builder: (context) => FinzenzAlert(
                            title: "Select Category",
                            body: "Please select a category for budget!",
                          ),
                        );
                        return;
                      }
                      if (startDate == null || endDate == null) {
                        showDialog(
                          context: widget.parentContext,
                          builder: (context) => FinzenzAlert(
                            title: "Select Date",
                            body:
                                "Please select start date as well as end date!",
                          ),
                        );
                        return;
                      }
                      if (formKey.currentState!.validate()) {
                        final categoryName =
                            CategoryIconMapper.getCategories()[selectedCategoryIndex!];

                        final success = await BudgetRepository().saveBudget(
                          category: categoryName,
                          amount:
                              double.tryParse(_amountController.text) ?? 0.0,
                          startDate: startDate!,
                          endDate: endDate!,
                        );

                        if (success) {
                          context.read<HomeCubit>().fetchBudgets();
                          await showDialog(
                            context: widget.parentContext,
                            builder: (context) => FinzenzAlert(
                              title: "Save Success",
                              body: "Your budget is saved successfully!",
                            ),
                          );
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
  }
}
