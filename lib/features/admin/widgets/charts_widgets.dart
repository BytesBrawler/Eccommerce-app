import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../model/sales_model.dart';

class BarChartWidget extends StatelessWidget {
  final List<Sales> salesList;

  const BarChartWidget(this.salesList, {super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // You can adjust the aspect ratio to fit your layout
      child: BarChart(
        BarChartData(
          barTouchData: BarTouchData(
            enabled: true,
          ),
          alignment: BarChartAlignment.center,
          maxY: getMaxYValue(),
          barGroups: getBarGroups(),
          titlesData: getTitlesData(),
          borderData: FlBorderData(
            show: false,
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
        ),
      ),
    );
  }

  double getMaxYValue() {
    return salesList
        .map((sales) => sales.earning.toDouble())
        .reduce((max, earning) => earning > max ? earning : max);
  }

  List<BarChartGroupData> getBarGroups() {
    return List.generate(salesList.length, (index) {
      final sales = salesList[index];
      return BarChartGroupData(
        groupVertically: false,
        x: index,
        barRods: [
          BarChartRodData(toY: sales.earning.toDouble(), color: Colors.blue),
        ],
        // showingTooltipIndicators: [sales.earning],
        // Specify the space between bars here
        barsSpace: 199.0,
      );
    });
  }

  FlTitlesData getTitlesData() {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 42,
          getTitlesWidget: (value, meta) {
            return Transform.rotate(
              angle: 1.5,
              child: Text(salesList[value.toInt()].label.toString()),
            );
          },
        ),

        // },
      ),
      leftTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 42,
        ),
      ),
      rightTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
          reservedSize: 42,
        ),
      ),
      topTitles: const AxisTitles(
        sideTitles: SideTitles(
          showTitles: false,
          reservedSize: 42,
        ),
      ),
    );
  }
}
