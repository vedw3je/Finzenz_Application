import 'package:finzenz_app/modules/home/bloc/home_cubit.dart';
import 'package:finzenz_app/modules/home/bloc/home_state.dart';
import 'package:finzenz_app/modules/stats/widgets/spending_pie_chart.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

            final List<_CategoryData> pieData = categoryTotals.entries
                .map((e) => _CategoryData(e.key, e.value))
                .toList();

            // Group by day of month
            final Map<int, double> dailyTotals = {};
            for (var tx in transactions) {
              final day = tx.transactionDate.day;
              dailyTotals[day] = (dailyTotals[day] ?? 0) + tx.amount;
            }

            final List<_DailyData> lineData =
                dailyTotals.entries
                    .map((e) => _DailyData(e.key, e.value))
                    .toList()
                  ..sort((a, b) => a.day.compareTo(b.day));

            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 25),
                  SpendingPieChart(
                    pieData: [
                      CategoryData(
                        "Food",
                        300,
                        const Color(0xFFEF9A9A),
                      ), // Soft Red
                      CategoryData(
                        "Travel",
                        150,
                        const Color(0xFF80DEEA),
                      ), // Soft Cyan
                      CategoryData(
                        "Shopping",
                        220,
                        const Color(0xFFFFE082),
                      ), // Soft Yellow
                      CategoryData(
                        "Bills",
                        180,
                        const Color(0xFFA5D6A7),
                      ), // Soft Green
                      CategoryData(
                        "Entertainment",
                        250,
                        const Color(0xFFCE93D8),
                      ),
                    ],
                  ),

                  // Line Chart - Daily spending trend
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 6,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: SfCartesianChart(
                          title: ChartTitle(text: "Daily Spending Trend"),
                          primaryXAxis: NumericAxis(
                            title: AxisTitle(text: "Day"),
                          ),
                          primaryYAxis: NumericAxis(
                            title: AxisTitle(text: "Amount"),
                          ),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          series: <CartesianSeries>[
                            LineSeries<_DailyData, int>(
                              dataSource: lineData,
                              xValueMapper: (_DailyData data, _) => data.day,
                              yValueMapper: (_DailyData data, _) => data.amount,
                              dataLabelSettings: const DataLabelSettings(
                                isVisible: true,
                              ),
                              markerSettings: const MarkerSettings(
                                isVisible: true,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
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

class _CategoryData {
  final String category;
  final double amount;
  _CategoryData(this.category, this.amount);
}

class _DailyData {
  final int day;
  final double amount;
  _DailyData(this.day, this.amount);
}
