import 'dart:ui';

import 'package:finzenz_app/commonwidgets/alert_box.dart';
import 'package:finzenz_app/commonwidgets/textfieldwidget.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/date_picker_field.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/transaction_submit_button.dart';
import 'package:finzenz_app/modules/home/bloc/home_cubit.dart';
import 'package:finzenz_app/modules/home/repository/loan_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class AddLoanModal extends StatefulWidget {
  const AddLoanModal({super.key, required this.parentContext});

  final BuildContext parentContext;

  @override
  State<AddLoanModal> createState() => _AddLoanModalState();
}

class _AddLoanModalState extends State<AddLoanModal> {
  final TextEditingController _lenderNameController = TextEditingController();
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _interestRateController = TextEditingController();
  final TextEditingController _emiController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _recurringIntervalController = TextEditingController();
  final TextEditingController _totalInstallmentsController = TextEditingController();

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
                    "Add Loan 💰",
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

                  /// Lender Name
                  AppTextFormField(
                    label: "Lender Name",
                    hintText: "Enter lender name",
                    controller: _lenderNameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter lender name";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  /// Principal Amount
                  AppTextFormField(
                    label: "Principal Amount",
                    hintText: "Enter principal amount",
                    keyboardType: TextInputType.number,
                    controller: _principalController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter principal amount";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  /// Interest Rate
                  AppTextFormField(
                    label: "Interest Rate (%)",
                    hintText: "Enter interest rate",
                    keyboardType: TextInputType.number,
                    controller: _interestRateController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter interest rate";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  /// EMI Amount
                  AppTextFormField(
                    label: "EMI Amount",
                    hintText: "Enter EMI amount",
                    keyboardType: TextInputType.number,
                    controller: _emiController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter EMI amount";
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
                        _startDateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
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
                        _endDateController.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                      });
                    },
                  ),

                  const SizedBox(height: 20),

                  /// Recurring Interval Days
                  AppTextFormField(
                    label: "Recurring Interval (Days)",
                    hintText: "e.g., 30 for monthly",
                    keyboardType: TextInputType.number,
                    controller: _recurringIntervalController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter recurring interval days";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 16),

                  /// Total Installments
                  AppTextFormField(
                    label: "Total Installments",
                    hintText: "Enter total number of installments",
                    keyboardType: TextInputType.number,
                    controller: _totalInstallmentsController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter total installments";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20),

                  /// Submit Button
                  TransactionSubmitButton(
                    label: "Save Loan",
                    onTap: () async {
                      if (startDate == null || endDate == null) {
                        showDialog(
                          context: widget.parentContext,
                          builder: (context) => const FinzenzAlert(
                            title: "Select Date",
                            body: "Please select start and end dates!",
                          ),
                        );
                        return;
                      }
                      if (formKey.currentState!.validate()) {
                        final success = await LoanRepository().saveLoan(
                          lenderName: _lenderNameController.text,
                          principalAmount:
                          double.tryParse(_principalController.text) ?? 0.0,
                          interestRate:
                          double.tryParse(_interestRateController.text) ?? 0.0,
                          emiAmount:
                          double.tryParse(_emiController.text) ?? 0.0,
                          startDate: startDate!,
                          endDate: endDate!,
                          recurringIntervalDays:
                          int.tryParse(_recurringIntervalController.text) ?? 0,
                          totalInstallments:
                          int.tryParse(_totalInstallmentsController.text) ?? 0,
                        );

                        if (success) {
                          context.read<HomeCubit>().fetchLoans();
                          await showDialog(
                            context: widget.parentContext,
                            builder: (context) => const FinzenzAlert(
                              title: "Save Success",
                              body: "Your loan is saved successfully!",
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
