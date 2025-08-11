import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  final String label;
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateSelected;
  final TextEditingController? controller;

  const DatePickerField({
    super.key,
    required this.label,
    this.initialDate,
    required this.onDateSelected,
    this.controller,
  });

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  late TextEditingController _controller;
  DateTime? _selectedDate;

  String _formatDateTime(DateTime date) {
    final datePart = DateFormat('yyyy-MM-dd').format(date);
    final timePart = DateFormat('h a').format(date); // e.g. 5 PM
    return '$datePart at $timePart';
  }

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _controller =
        widget.controller ??
        TextEditingController(
          text: _selectedDate != null ? _formatDateTime(_selectedDate!) : '',
        );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(now.year + 5),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _controller.text = _formatDateTime(picked);
      });
      widget.onDateSelected(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      readOnly: true,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFFF0F4F8),
        labelText: widget.label,
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
      onTap: _pickDate,
      validator: (value) {
        if (_selectedDate == null) {
          return "Please select a date";
        }
        return null;
      },
    );
  }
}
