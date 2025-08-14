import 'dart:developer';
import 'dart:ui';
import 'package:finzenz_app/commonwidgets/alert_box.dart';
import 'package:finzenz_app/modules/add_account/widgets/bank_dropdown.dart';
import 'package:finzenz_app/modules/home/bloc/home_cubit.dart';
import 'package:finzenz_app/modules/home/bloc/home_state.dart';
import 'package:finzenz_app/modules/home/repository/account_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../commonwidgets/textfieldwidget.dart';
import '../../../prefservice.dart';
import '../widgets/account_type_selector.dart';
import '../widgets/currency_picker.dart';

class AccountModal extends StatefulWidget {
  const AccountModal({super.key, required this.parentContext});

  final BuildContext parentContext;

  @override
  State<AccountModal> createState() => _AccountModalState();
}

class _AccountModalState extends State<AccountModal> {
  final formKey = GlobalKey<FormState>();

  String? selectedAccountType;
  final TextEditingController _accountNameController = TextEditingController();
  final TextEditingController _institutionNameController =
      TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _balanceController = TextEditingController();
  final TextEditingController _currencyController = TextEditingController();
  bool _isActive = true;

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
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              final cubit = context.read<HomeCubit>();
              return SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
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

                      Text(
                        "Add Account 🏦",
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

                      _buildAppTextFormField(
                        label: "Account Name",
                        hintText: "Enter a name for your account",
                        controller: _accountNameController,
                      ),

                      AccountTypeSelector(
                        selectedType: selectedAccountType,
                        onChanged: (value) {
                          setState(() {
                            selectedAccountType = value;
                          });
                        },
                      ),
                      const SizedBox(height: 16),

                      // _buildAppTextFormField(
                      //   label: "Institution Name",
                      //   hintText: "e.g. SBI , HDFC",
                      //   controller: _institutionNameController,
                      // ),
                      BankDropdown(
                        label: "Bank / Institution",
                        controller: _institutionNameController,
                      ),

                      _buildAppTextFormField(
                        label: "Account Number",
                        hintText: "Enter your 12-digit account number",
                        controller: _accountNumberController,
                        keyboardType: TextInputType.number,
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: _buildAppTextFormField(
                              label: "Balance",
                              hintText: "Enter balance",
                              controller: _balanceController,
                              keyboardType: TextInputType.number,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: CurrencyPicker(
                              selectedCurrency: _currencyController.text.isEmpty
                                  ? null
                                  : _currencyController.text,
                              onChanged: (value) {
                                _currencyController.text = value;
                              },
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Is Active",
                            style: TextStyle(fontSize: 16),
                          ),
                          Switch(
                            value: _isActive,
                            onChanged: (value) {
                              setState(() {
                                _isActive = value;
                              });
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0D1B2A),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                            horizontal: 24,
                          ),
                        ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            final user = await PrefService.getUser();
                            if (user == null) {
                              // some redirect to login logic here
                              return;
                            }
                            final userId = user.id;
                            final saved = await AccountRepository().saveAccount(
                              accountName: _accountNameController.text,
                              accountType: AccountTypeSelector.getTypeName(
                                selectedAccountType!,
                              ),
                              institutionName: _institutionNameController.text,
                              accountNumber: _accountNumberController.text,
                              balance:
                                  double.tryParse(_balanceController.text) ??
                                  0.0,
                              currency: _currencyController.text,
                              isActive: _isActive,
                              userId: userId,
                            );
                            if (saved) {
                              await showDialog(
                                context: widget.parentContext,
                                builder: (context) => const FinzenzAlert(
                                  title: "Save Account Successful",
                                  body:
                                      "Your Account has been saved successfully!",
                                ),
                              );
                              cubit.fetchAccounts();

                              Navigator.pop(context);
                            } else {
                              showDialog(
                                context: widget.parentContext,
                                builder: (context) => const FinzenzAlert(
                                  title: "Account Could not be saved",
                                  body:
                                      "Your Account could not be saved. Please try again!",
                                ),
                              );
                            }

                            print("Account Saved: $saved");
                          }
                        },

                        child: const Text(
                          "Save Account",
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAppTextFormField({
    required String label,
    required String hintText,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: AppTextFormField(
        label: label,
        hintText: hintText,
        keyboardType: keyboardType,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter $label";
          }
          return null;
        },
      ),
    );
  }
}
