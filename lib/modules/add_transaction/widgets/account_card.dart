import 'package:finzenz_app/modules/home/model/account_model.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

class AccountCard extends StatelessWidget {
  final Account account;
  final bool? isProfile; // null = not profile mode
  final bool isSelected;

  const AccountCard({
    super.key,
    required this.account,
    this.isProfile,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 240,
      margin: const EdgeInsets.only(right: 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: (isProfile == null)
              ? isSelected
                    ? Colors.blue.shade300
                    : Colors.grey.shade200
              : Colors.blue.shade300,
          width: 1.4,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              gradient: (isProfile == null)
                  ? isSelected
                        ? LinearGradient(
                            colors: [
                              Colors.blue.shade50.withOpacity(0.9),
                              Colors.blue.shade100.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                        : LinearGradient(
                            colors: [
                              Colors.white.withOpacity(0.9),
                              Colors.grey.shade100.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          )
                  : null,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: (isProfile == null)
                          ? isSelected
                                ? [Colors.blue, Colors.blue.shade400]
                                : [Colors.grey.shade400, Colors.grey.shade300]
                          : [Colors.blue, Colors.blue.shade400],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.withOpacity(0.25),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(6),
                  child: const Icon(
                    Icons.account_balance,
                    size: 28,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        account.institutionName ?? "Unknown Bank",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 0.3,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        account.accountNumber ?? "N/A",
                        style: TextStyle(
                          color: Colors.grey.shade700,
                          fontSize: 14,
                          letterSpacing: 0.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Balance: ${account.balance?.toStringAsFixed(2) ?? '0.00'} ${account.currency ?? ''}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          color: (isProfile == null)
                              ? isSelected
                                    ? Colors.blue.shade800
                                    : Colors.grey.shade800
                              : Colors.grey.shade800,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
