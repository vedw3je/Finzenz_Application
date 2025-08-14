import 'dart:developer';

import 'package:finzenz_app/commonwidgets/alert_box.dart';
import 'package:finzenz_app/modules/add_transaction/widgets/account_card.dart';
import 'package:finzenz_app/modules/home/model/account_model.dart';
import 'package:finzenz_app/modules/profile/widget/add_account_button.dart';
import 'package:flutter/material.dart';

import '../../add_account/screens/account_modal.dart';

class AccountSelector extends StatelessWidget {
  final List<Account> accounts;
  final int? selectedIndex;
  final Function(int) onSelected;
  final bool? isProfile;

  const AccountSelector({
    super.key,
    required this.accounts,
    required this.selectedIndex,
    required this.onSelected,
    this.isProfile,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140,
      child: ListView.builder(
        padding: EdgeInsets.all(0),
        scrollDirection: Axis.horizontal,
        itemCount: (isProfile == null) ? accounts.length : accounts.length + 1,
        itemBuilder: (context, index) {
          if (index == accounts.length && isProfile == true) {
            return AddButton(
              buttonText: "Add Account",
              onTap: () {
                print("Add account tapped");

                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: AccountModal(parentContext: context),
                    );
                  },
                );
              },
            );
          }

          final account = accounts[index];
          final isSelected = index == selectedIndex;

          return GestureDetector(
            onLongPress: () {
              if (isProfile == true) {
                showDialog(
                  context: context,
                  builder: (context) => FinzenzAlert(
                    isDeleteDialog: true,
                    title: "Delete Account",
                    body: "Are you sure you want to delete your account",
                    onOkay: () {
                      log("okay pressed");
                    },
                  ),
                );
              }
            },
            onTap: () => onSelected(index),
            child: AccountCard(
              account: accounts[index],
              isProfile: true,
              isSelected: selectedIndex == index,
            ),
          );
        },
      ),
    );
  }
}
