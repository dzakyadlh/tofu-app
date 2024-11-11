import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:tofu/theme.dart';

class OutcomePieChart extends StatefulWidget {
  final Map<String, Map<String, double>> transactionData;

  const OutcomePieChart({super.key, required this.transactionData});

  @override
  State<StatefulWidget> createState() => _OutcomePieChartState();
}

class _OutcomePieChartState extends State<OutcomePieChart> {
  int touchedIndex = -1;

  handleColor(int percentage) {
    if (percentage >= 40) {
      return Colors.red.shade900;
    } else if (percentage >= 30) {
      return Colors.orange.shade800;
    } else if (percentage >= 15) {
      return Colors.orange.shade500;
    } else {
      return Colors.yellow.shade600;
    }
  }

  @override
  Widget build(BuildContext context) {
    final outcomeData = widget.transactionData;
    bool hasOutcome = outcomeData.values
        .any((categoryData) => (categoryData['outcome'] ?? 0) > 0);

    if (!hasOutcome) {
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
              "You don't have any outcome data.",
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
              "Don't be stingy! Spend some money when you need it.",
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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: generateLegends(outcomeData),
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    final outcomeData = widget.transactionData;
    double totalOutcome = 0;

    // Calculate the total outcome
    outcomeData.forEach((_, categoryData) {
      totalOutcome += categoryData['outcome'] ?? 0;
    });

    // Generate pie chart sections
    List<PieChartSectionData> sections = [];
    int index = 0;
    outcomeData.forEach((category, categoryData) {
      double outcome = categoryData['outcome'] ?? 0;
      if (outcome > 0) {
        double percentage = (outcome / totalOutcome) * 100;
        sections.add(
          PieChartSectionData(
            color: handleColor(percentage.toInt()),
            value: percentage,
            title: '${percentage.toStringAsFixed(1)}%',
            radius: index == touchedIndex ? 60.0 : 50.0,
            titleStyle: secondaryTextStyle.copyWith(
              fontSize: index == touchedIndex ? 16.0 : 12.0,
              fontWeight: semibold,
              shadows: [const Shadow(color: Colors.black, blurRadius: 2)],
            ),
          ),
        );
        index++;
      }
    });

    return sections;
  }

  List<Widget> generateLegends(Map<String, Map<String, double>> outcomeData) {
    List<Widget> legends = [];
    int index = 0;

    outcomeData.forEach((category, categoryData) {
      double outcome = categoryData['outcome'] ?? 0;
      if (outcome > 0) {
        // Generate legend only for categories with outcome
        legends.add(
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: handleColor(((outcome /
                            (outcomeData.values.fold(0,
                                (sum, item) => sum + (item['outcome'] ?? 0))) *
                            100))
                        .toInt()),
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  category,
                  style: secondaryTextStyle.copyWith(fontSize: 10),
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
