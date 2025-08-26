import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DailyData {
  final int day;
  final double amount;

  DailyData(this.day, this.amount);
}

class SpendingLineChart extends StatelessWidget {
  final List<DailyData> lineData;

  const SpendingLineChart({Key? key, required this.lineData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        elevation: 12,
        shadowColor: Colors.indigo.withOpacity(0.3),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.indigo.shade400, Colors.indigo.shade900],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.indigoAccent.withOpacity(0.4),
                blurRadius: 18,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SfCartesianChart(
              title: ChartTitle(
                text: "📈 Daily Spending Trend",
                textStyle: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      color: Colors.indigoAccent,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    ),
                  ],
                ),
              ),
              primaryXAxis: NumericAxis(
                title: AxisTitle(
                  text: "Day",
                  textStyle: const TextStyle(color: Colors.white70),
                ),
                labelStyle: const TextStyle(color: Colors.white),
              ),
              primaryYAxis: NumericAxis(
                title: AxisTitle(
                  text: "Amount",
                  textStyle: const TextStyle(color: Colors.white70),
                ),
                labelStyle: const TextStyle(color: Colors.white),
              ),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: <CartesianSeries>[
                LineSeries<DailyData, int>(
                  dataSource: lineData,
                  xValueMapper: (DailyData data, _) => data.day,
                  yValueMapper: (DailyData data, _) => data.amount,
                  color: Colors.cyanAccent,
                  width: 3,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: true,
                    textStyle: TextStyle(color: Colors.white),
                  ),
                  markerSettings: const MarkerSettings(
                    isVisible: true,
                    shape: DataMarkerType.circle,
                    width: 8,
                    height: 8,
                    borderWidth: 2,
                    borderColor: Colors.white,
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
