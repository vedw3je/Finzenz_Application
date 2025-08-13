import 'package:finzenz_app/modules/add_transaction/widgets/account_selector.dart';
import 'package:finzenz_app/modules/home/model/account_model.dart';
import 'package:flutter/material.dart';

class AccountSelectorSection extends StatefulWidget {
  final List<Account> accounts;
  const AccountSelectorSection({super.key, required this.accounts});

  @override
  State<AccountSelectorSection> createState() => _AccountSelectorSectionState();
}

class _AccountSelectorSectionState extends State<AccountSelectorSection> {
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AccountSelector(
          accounts: widget.accounts,
          selectedIndex: selectedIndex,
          onSelected: (index) => setState(() => selectedIndex = index),
        ),
        const SizedBox(height: 20),
        if (selectedIndex != null)
          Text(
            "Selected Account: ${widget.accounts[selectedIndex!].accountName}",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
      ],
    );
  }
}
