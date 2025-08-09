import 'package:flutter/material.dart';

AppBar buildFinzenzAppBar() {
  return AppBar(
    elevation: 6,
    backgroundColor: const Color(0xFF0D1B2A), // deep blue
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0D1B2A), // deep blue
            Color(0xFF1B263B), // navy
            Color(0xFF144552), // teal hint
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    ),
    title: const Text(
      'Finzenz',
      style: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 22,
        letterSpacing: 1.2,
        color: Colors.white,
      ),
    ),
    centerTitle: true,
    actions: [
      IconButton(
        icon: const Icon(Icons.search, color: Colors.white70),
        onPressed: () {
          // search action
        },
      ),
      IconButton(
        icon: const Icon(Icons.account_circle_outlined, color: Colors.white70),
        onPressed: () {
          // profile action
        },
      ),
    ],
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
    ),
  );
}
