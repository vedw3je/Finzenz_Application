import 'dart:developer';
import 'package:finzenz_app/commonwidgets/alert_box.dart';
import 'package:finzenz_app/modules/home/model/loan_model.dart';
import 'package:finzenz_app/modules/profile/widget/add_account_button.dart';
import 'package:finzenz_app/modules/profile/widget/loan_card.dart';
import 'package:flutter/material.dart';

import '../../add_loans/loans_modal.dart';


class LoanList extends StatelessWidget {
  final List<Loan> loans;
  final int? selectedIndex;
  final Function(int) onSelected;
  final bool? isProfile;

  const LoanList({
    super.key,
    required this.loans,
    required this.selectedIndex,
    required this.onSelected,
    this.isProfile,
  });

  @override
  Widget build(BuildContext context) {
    if (loans.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: loans.length + 1,
        itemBuilder: (context, index) {
          if (index == loans.length) {
            return AddButton(
              buttonText: "Add Loan",
              onTap: () => _showAddLoanModal(context),
            );
          }

          final loan = loans[index];
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onLongPress: () => _showDeleteLoanDialog(context, loan),
            onTap: () => onSelected(index),
            child: LoanCard(
              loan: loan,
              isProfile: isProfile,
              isSelected: isSelected,
            ),
          );
        },
      ),
    );
  }

  void _showAddLoanModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: AddLoanModal(parentContext: context),
        );
      },
    );
  }

  void _showDeleteLoanDialog(BuildContext context, Loan loan) {
    showDialog(
      context: context,
      builder: (context) => FinzenzAlert(
        isDeleteDialog: true,
        title: "Delete Loan",
        body: "Are you sure you want to delete this loan?",
        onOkay: () {
          log("Loan delete confirmed for lender: ${loan.lenderName}");
        },
      ),
    );
  }
}
