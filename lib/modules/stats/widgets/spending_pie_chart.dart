import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SpendingPieChart extends StatelessWidget {
  final List<CategoryData> pieData;

  const SpendingPieChart({super.key, required this.pieData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 12,
        shadowColor: const Color.fromARGB(255, 249, 215, 255).withOpacity(0.6),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple.shade400, Colors.black87],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.purpleAccent.withOpacity(0.5),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SfCircularChart(
              title: ChartTitle(
                text: "Spending by Category",
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.purpleAccent,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              legend: Legend(
                isVisible: true,
                overflowMode: LegendItemOverflowMode.wrap,
                textStyle: const TextStyle(color: Colors.white),
              ),
              series: <CircularSeries>[
                PieSeries<CategoryData, String>(
                  dataSource: pieData,
                  xValueMapper: (CategoryData data, _) => data.category,
                  yValueMapper: (CategoryData data, _) => data.amount,
                  pointColorMapper: (CategoryData data, _) => data.color,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  explode: true,
                  explodeIndex: 0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CategoryData {
  final String category;
  final double amount;
  final Color color;

  CategoryData(this.category, this.amount, this.color);
}
