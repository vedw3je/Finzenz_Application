import 'dart:math';

import 'package:finzenz_app/modules/home/bloc/home_cubit.dart';
import 'package:finzenz_app/modules/home/bloc/home_state.dart';
import 'package:finzenz_app/modules/stats/widgets/spending_line_chart.dart';
import 'package:finzenz_app/modules/stats/widgets/spending_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeFetched) {
            final transactions = state.transactions;

            if (transactions.isEmpty) {
              return const Center(child: Text("No transactions this month."));
            }

            // Group by category
            final Map<String, double> categoryTotals = {};
            for (var tx in transactions) {
              categoryTotals[tx.category] =
                  (categoryTotals[tx.category] ?? 0) + tx.amount;
            }

            // 🎨 Define a color palette
            final List<Color> palette = [
              const Color(0xFFEF9A9A), // soft red
              const Color(0xFF80DEEA), // soft cyan
              const Color(0xFFFFE082), // soft yellow
              const Color(0xFFA5D6A7), // soft green
              const Color(0xFFCE93D8), // soft purple
              const Color(0xFFFFAB91), // soft orange
              const Color(0xFFB39DDB), // soft indigo
            ];

            // Assign colors dynamically from palette
            int colorIndex = 0;
            final List<CategoryData> pieData = categoryTotals.entries.map((e) {
              final color = palette[colorIndex % palette.length];
              colorIndex++;
              return CategoryData(e.key, e.value, color);
            }).toList();

            // Group by day of month
            final Map<int, double> dailyTotals = {};
            for (var tx in transactions) {
              final day = tx.transactionDate.day;
              dailyTotals[day] = (dailyTotals[day] ?? 0) + tx.amount;
            }

            final List<DailyData> lineData =
                dailyTotals.entries
                    .map((e) => DailyData(e.key, e.value))
                    .toList()
                  ..sort((a, b) => a.day.compareTo(b.day));

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  SpendingPieChart(pieData: pieData),

                  SpendingLineChart(lineData: lineData),
                ],
              ),
            );
          } else if (state is HomeError) {
            return Center(child: Text("Error: ${state.message}"));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
