import 'dart:developer';
import 'package:finzenz_app/commonwidgets/alert_box.dart';
import 'package:finzenz_app/modules/add_budgets/budgets_modal.dart';
import 'package:finzenz_app/modules/home/helpers/category_icon_mappers.dart';
import 'package:finzenz_app/modules/home/model/budget_model.dart';
import 'package:finzenz_app/modules/profile/widget/add_account_button.dart';
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
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              width: 220,
              margin: const EdgeInsets.only(right: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: (isProfile == null)
                    ? isSelected
                          ? LinearGradient(
                              colors: [
                                Colors.green.shade50,
                                Colors.green.shade100,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : LinearGradient(
                              colors: [Colors.white, Colors.grey.shade100],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                    : null,
                borderRadius: BorderRadius.circular(16),
                border: (isProfile == null)
                    ? Border.all(
                        color: isSelected ? Colors.green : Colors.grey.shade300,
                        width: 2,
                      )
                    : Border.all(color: Colors.green),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade300.withOpacity(0.4),
                    blurRadius: 10,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: (isProfile == null)
                        ? isSelected
                              ? Colors.green
                              : Colors.grey.shade300
                        : Colors.green,
                    child: Icon(
                      CategoryIconMapper.getIcon(budget.category),
                      size: 28,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          budget.category ?? "No Category",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${budget.amount?.toStringAsFixed(2) ?? '0.00'} ",
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "${budget.startDate.toString().substring(0, 11)} → ${budget.endDate.toString().substring(0, 11)}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
