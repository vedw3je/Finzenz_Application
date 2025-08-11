import 'package:flutter/material.dart';

class TransactionTypeSelector extends StatelessWidget {
  final int? selectedIndex;
  final Function(int) onSelected;

  static const List<String> _types = ["CREDIT", "DEBIT", "TRANSFER"];

  const TransactionTypeSelector({
    Key? key,
    required this.selectedIndex,
    required this.onSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: List.generate(_types.length, (index) {
        final isSelected = selectedIndex == index;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
          decoration: BoxDecoration(
            color: isSelected ? Colors.grey[200] : Colors.white,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: isSelected ? 8 : 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ChoiceChip(
            labelPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 4,
            ),
            label: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 200),
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: isSelected ? 16 : 15,
              ),
              child: Text(_types[index]),
            ),
            selected: isSelected,
            selectedColor: Colors.grey[200], // container handles color
            backgroundColor: Colors.white,
            pressElevation: 0,
            onSelected: (_) => onSelected(index),
          ),
        );
      }),
    );
  }

  static String getTypeName(int index) => _types[index];
}
