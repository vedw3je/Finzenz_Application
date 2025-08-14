import 'dart:developer';
import 'package:finzenz_app/commonwidgets/alert_box.dart';
import 'package:finzenz_app/modules/add_budgets/budgets_modal.dart';
import 'package:finzenz_app/modules/home/helpers/category_icon_mappers.dart';
import 'package:finzenz_app/modules/home/model/budget_model.dart';
import 'package:finzenz_app/modules/profile/widget/add_account_button.dart';
import 'package:finzenz_app/modules/profile/widget/budget_card.dart';
import 'package:flutter/material.dart';

class BudgetList extends StatelessWidget {
  final List<Budget> budgets;
  final int? selectedIndex;
  final Function(int) onSelected;
  final bool? isProfile;

  const BudgetList({
    super.key,
    required this.budgets,
    required this.selectedIndex,
    required this.onSelected,
    this.isProfile,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: budgets.length + 1,
        itemBuilder: (context, index) {
          if (index == budgets.length) {
            return AddButton(
              buttonText: "Add Budget",
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: AddBudgetModal(parentContext: context),
                    );
                  },
                );
              },
            );
          }

          final budget = budgets[index];
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onLongPress: () {
              showDialog(
                context: context,
                builder: (context) => FinzenzAlert(
                  isDeleteDialog: true,
                  title: "Delete Budget",
                  body: "Are you sure you want to delete this budget?",
                  onOkay: () {
                    log("Budget delete confirmed for: ${budget.category}");
                  },
                ),
              );
            },
            onTap: () => onSelected(index),
            child: BudgetCard(
              budget: budget,
              isProfile: isProfile,
              isSelected: isSelected,
            ),
          );
        },
      ),
    );
  }
}
