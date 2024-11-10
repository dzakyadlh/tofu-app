import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tofu/providers/transaction_provider.dart';
import 'package:tofu/theme.dart';

class MonthlyCashflow extends StatefulWidget {
  MonthlyCashflow({super.key});

  final Color income = primaryColor;
  final Color outcome = alertColor;

  final List<Map<String, double>> yearSummary = [
    {'income': 12000, 'outcome': 5000}, // Jan
    {'income': 11000, 'outcome': 4000}, // Feb
    {'income': 14000, 'outcome': 6000}, // Mar
    {'income': 13000, 'outcome': 5000}, // Apr
    {'income': 12500, 'outcome': 4500}, // May
    {'income': 13500, 'outcome': 5500}, // Jun
    {'income': 15000, 'outcome': 6000}, // Jul
    {'income': 14500, 'outcome': 5000}, // Aug
    {'income': 16000, 'outcome': 7000}, // Sep
    {'income': 15500, 'outcome': 6500}, // Oct
  ];

  @override
  State<MonthlyCashflow> createState() => _MonthlyCashflowState();
}

class _MonthlyCashflowState extends State<MonthlyCashflow> {
  Widget bottomTitles(double value, TitleMeta meta) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final month = months.elementAt(value.toInt() % months.length);
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(month, style: subtitleTextStyle.copyWith(fontSize: 10)),
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    if (value == meta.max) {
      return Container();
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(
        meta.formattedValue,
        style: subtitleTextStyle.copyWith(fontSize: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TransactionProvider transactionProvider = Provider.of(context);
    int selectedYear =
        DateTime.now().year; // You can make this dynamic as needed

    Map<String, List<Map<String, double>>> data =
        transactionProvider.getMonthlySummary(selectedYear);
    List<Map<String, double>> yearSummary = data['monthlySummary']!;

    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1.66,
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final barsSpace = 20.0 * constraints.maxWidth / 400;
                final barsWidth = 12.0 * constraints.maxWidth / 400;
                return BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.center,
                    barTouchData: BarTouchData(
                      enabled: false,
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 28,
                          getTitlesWidget: bottomTitles,
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: leftTitles,
                        ),
                      ),
                      topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      checkToShowHorizontalLine: (value) => value % 10 == 0,
                      getDrawingHorizontalLine: (value) => const FlLine(
                        color: Colors.white12,
                        strokeWidth: 1,
                      ),
                      drawVerticalLine: false,
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    groupsSpace: barsSpace,
                    barGroups: List.generate(yearSummary.length, (index) {
                      final income = yearSummary[index]['income']!;
                      final outcome = yearSummary[index]['outcome']!;
                      return BarChartGroupData(
                        x: index,
                        barsSpace: barsSpace,
                        barRods: [
                          BarChartRodData(
                            toY: income + outcome,
                            rodStackItems: [
                              BarChartRodStackItem(0, outcome, widget.outcome),
                              BarChartRodStackItem(
                                  outcome, income + outcome, widget.income),
                            ],
                            borderRadius: BorderRadius.zero,
                            width: barsWidth,
                          ),
                        ],
                      );
                    }),
                  ),
                );
              },
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LegendItem(color: widget.income, label: "Income"),
            const SizedBox(width: 16),
            LegendItem(color: widget.outcome, label: "Outcome"),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  List<BarChartGroupData> getData(double barsWidth, double barsSpace) {
    return List.generate(widget.yearSummary.length, (index) {
      final income = widget.yearSummary[index]['income']!;
      final outcome = widget.yearSummary[index]['outcome']!;
      return BarChartGroupData(
        x: index,
        barsSpace: barsSpace,
        barRods: [
          BarChartRodData(
            toY: income + outcome,
            rodStackItems: [
              BarChartRodStackItem(0, outcome, widget.outcome),
              BarChartRodStackItem(outcome, income + outcome, widget.income),
            ],
            borderRadius: BorderRadius.zero,
            width: barsWidth,
          ),
        ],
      );
    });
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({
    super.key,
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: subtitleTextStyle.copyWith(fontSize: 10),
        ),
      ],
    );
  }
}
