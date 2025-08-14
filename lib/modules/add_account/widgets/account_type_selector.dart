import 'package:flutter/material.dart';

class AccountTypeSelector extends StatelessWidget {
  final String? selectedType;
  final ValueChanged<String?> onChanged;

  static const List<String> _accountTypes = [
    "CREDIT",
    "SAVINGS",
    "INVESTMENTS",
    "CURRENT",
    "RECURRING",
    "FIXED_DEPOSIT",
    "NRI"
  ];

  const AccountTypeSelector({
    Key? key,
    required this.selectedType,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedType,
      items: _accountTypes.map((type) {
        return DropdownMenuItem<String>(
          value: type,
          child: Text(
            type.replaceAll('_', ' '), // Display FIXED_DEPOSIT as FIXED DEPOSIT
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: "Account Type",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please select an account type";
        }
        return null;
      },
    );
  }

  static String getTypeName(String value) => value;
}
