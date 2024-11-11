import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class IncomePieChart extends StatefulWidget {
  final Map<String, Map<String, double>> transactionData;

  const IncomePieChart({super.key, required this.transactionData});

  @override
  State<StatefulWidget> createState() => _IncomePieChartState();
}

class _IncomePieChartState extends State<IncomePieChart> {
  int touchedIndex = -1;

  handleColor(int percentage) {
    if (percentage >= 60) {
      return Colors.purple.shade900;
    } else if (percentage >= 40) {
      return Colors.purple.shade600;
    } else if (percentage >= 30) {
      return Colors.purple.shade400;
    } else if (percentage >= 15) {
      return Colors.blue.shade600;
    } else {
      return Colors.blue.shade300;
    }
  }

  @override
  Widget build(BuildContext context) {
    final incomeData = widget.transactionData;
    bool hasIncome = incomeData.values
        .any((categoryData) => (categoryData['income'] ?? 0) > 0);

    if (!hasIncome) {
      return Center(
        child: Column(
          children: [
            Image.asset(
              'assets/images/despair.png',
              width: 200,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "You don't have any income data.",
              style: secondaryTextStyle.copyWith(
                fontSize: 14,
                fontWeight: semibold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 4,
            ),
            Text(
              "Don't be lazy! Work hard and earn some money to reach your goal!",
              style: subtitleTextStyle.copyWith(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AspectRatio(
          aspectRatio: 1.3,
          child: Row(
            children: <Widget>[
              const SizedBox(
                height: 18,
              ),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          setState(() {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex = -1;
                              return;
                            }
                            touchedIndex = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          });
                        },
                      ),
                      borderData: FlBorderData(
                        show: false,
                      ),
                      sectionsSpace: 10,
                      centerSpaceRadius: 60,
                      sections: showingSections(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16), // Add spacing between chart and legends
        Wrap(
          spacing: 8.0, // Space between each legend item
          runSpacing: 4.0, // Space between rows of legends
          children: generateLegends(incomeData),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    final incomeData = widget.transactionData;
    double totalIncome = 0;

    // Calculate the total income
    incomeData.forEach((_, categoryData) {
      totalIncome += categoryData['income'] ?? 0;
    });

    // Generate pie chart sections
    List<PieChartSectionData> sections = [];
    int index = 0;
    incomeData.forEach((category, categoryData) {
      double income = categoryData['income'] ?? 0;
      if (income > 0) {
        double percentage = (income / totalIncome) * 100;
        sections.add(
          PieChartSectionData(
            color: handleColor(percentage.toInt()),
            value: percentage,
            title: '${percentage.toStringAsFixed(1)}%',
            radius: index == touchedIndex ? 60.0 : 50.0,
            titleStyle: secondaryTextStyle.copyWith(
              fontSize: index == touchedIndex ? 16.0 : 12.0,
              fontWeight: bold,
              shadows: [const Shadow(color: Colors.black, blurRadius: 2)],
            ),
          ),
        );
        index++;
      }
    });

    return sections;
  }

  List<Widget> generateLegends(Map<String, Map<String, double>> incomeData) {
    List<Widget> legends = [];
    int index = 0;

    incomeData.forEach((category, categoryData) {
      double income = categoryData['income'] ?? 0;
      if (income > 0) {
        // Generate legend only for categories with income
        legends.add(
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: handleColor(((income /
                            (incomeData.values.fold(0,
                                (sum, item) => sum + (item['income'] ?? 0))) *
                            100))
                        .toInt()),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  category,
                  style: secondaryTextStyle.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
        );
        index++;
      }
    });

    return legends;
  }
}
