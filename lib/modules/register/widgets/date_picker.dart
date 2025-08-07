import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerTextField extends StatefulWidget {
  final TextEditingController controller;

  const DatePickerTextField({super.key, required this.controller});

  @override
  State<DatePickerTextField> createState() => _DatePickerTextFieldState();
}

class _DatePickerTextFieldState extends State<DatePickerTextField> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime(2100),
        );

        if (picked != null) {
          widget.controller.text = DateFormat('dd-MM-yyyy').format(picked);
        }
      },
      child: AbsorbPointer(
        child: Material(
          elevation: 2,
          shadowColor: Colors.grey.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          child: TextFormField(
            controller: widget.controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color(0xFFF0F4F8),
              labelText: "Date of Birth",
              hintText: "Select date",
              labelStyle: const TextStyle(color: Colors.black87),
              hintStyle: const TextStyle(color: Colors.grey),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
