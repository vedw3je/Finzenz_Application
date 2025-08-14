import 'package:flutter/material.dart';

import '../helper/bank_data.dart';

class BankDropdown extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const BankDropdown({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<BankDropdown> createState() => _BankDropdownState();
}

class _BankDropdownState extends State<BankDropdown> {
  String? selectedCode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: DropdownButtonFormField<String>(
        value: selectedCode,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 10,
          ),
        ),
        items: bankInstitutes.entries.map((entry) {
          return DropdownMenuItem<String>(
            value: entry.key, // Code stored in controller
            child: Text(entry.value), // Full name shown
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            selectedCode = value;
          });
          widget.controller.text = value ?? ''; // Store only the code
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please select ${widget.label}";
          }
          return null;
        },
      ),
    );
  }
}
