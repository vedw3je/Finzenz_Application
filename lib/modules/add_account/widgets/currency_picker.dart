import 'package:flutter/material.dart';

class CurrencyPicker extends StatelessWidget {
  final String? selectedCurrency;
  final Function(String) onChanged;

  static const List<String> currencies = ["INR","USD","EUR","AED","JPY","CAD"];

  const CurrencyPicker({
    super.key,
    required this.selectedCurrency,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedCurrency,
      decoration: InputDecoration(
        labelText: "Currency",
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
      items: currencies.map((currency) {
        return DropdownMenuItem(
          value: currency,
          child: Text(currency),
        );
      }).toList(),
      onChanged: (value) {
        if (value != null) {
          onChanged(value);
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Please select a currency";
        }
        return null;
      },
    );
  }
}
