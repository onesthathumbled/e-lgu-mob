import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../shared/widgets/shadcn_components.dart';

/// Bar chart widget for displaying metrics
class ShadBarChart extends StatelessWidget {
  const ShadBarChart({
    super.key,
    required this.data,
    required this.labels,
    this.title,
    this.height = 200,
    this.colors,
    this.showValues = true,
    this.maxValue,
  });

  final List<double> data;
  final List<String> labels;
  final String? title;
  final double height;
  final List<Color>? colors;
  final bool showValues;
  final double? maxValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxDataValue = maxValue ?? data.reduce((a, b) => a > b ? a : b);
    final defaultColors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.teal,
    ];

    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
          ],
          SizedBox(
            height: height,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: maxDataValue * 1.1,
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: theme.colorScheme.surface,
                    tooltipBorder: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1,
                    ),
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${labels[group.x]}\n${rod.toY.toStringAsFixed(1)}',
                        theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface,
                        ) ?? TextStyle(color: theme.colorScheme.onSurface),
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        );
                        if (value.toInt() < labels.length) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              labels[value.toInt()],
                              style: style,
                            ),
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: maxDataValue / 5,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            value.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: data.asMap().entries.map((entry) {
                  final index = entry.key;
                  final value = entry.value;
                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: value,
                        color: colors?[index % (colors?.length ?? 1)] ?? 
                               defaultColors[index % defaultColors.length],
                        width: 20,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                        ),
                      ),
                    ],
                  );
                }).toList(),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: maxDataValue / 5,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: theme.colorScheme.outline.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Line chart widget for displaying trends
class ShadLineChart extends StatelessWidget {
  const ShadLineChart({
    super.key,
    required this.data,
    required this.labels,
    this.title,
    this.height = 200,
    this.color,
    this.showPoints = true,
    this.showGrid = true,
  });

  final List<double> data;
  final List<String> labels;
  final String? title;
  final double height;
  final Color? color;
  final bool showPoints;
  final bool showGrid;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final maxValue = data.reduce((a, b) => a > b ? a : b);
    final minValue = data.reduce((a, b) => a < b ? a : b);
    final range = maxValue - minValue;
    final chartColor = color ?? theme.colorScheme.primary;

    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
          ],
          SizedBox(
            height: height,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: showGrid,
                  drawVerticalLine: false,
                  horizontalInterval: range / 5,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: theme.colorScheme.outline.withOpacity(0.2),
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        const style = TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        );
                        if (value.toInt() < labels.length) {
                          return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(
                              labels[value.toInt()],
                              style: style,
                            ),
                          );
                        }
                        return const Text('');
                      },
                      reservedSize: 30,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: range / 5,
                      getTitlesWidget: (double value, TitleMeta meta) {
                        return SideTitleWidget(
                          axisSide: meta.axisSide,
                          child: Text(
                            value.toStringAsFixed(0),
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                minX: 0,
                maxX: (data.length - 1).toDouble(),
                minY: minValue - (range * 0.1),
                maxY: maxValue + (range * 0.1),
                lineBarsData: [
                  LineChartBarData(
                    spots: data.asMap().entries.map((entry) {
                      return FlSpot(entry.key.toDouble(), entry.value);
                    }).toList(),
                    isCurved: true,
                    color: chartColor,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: showPoints,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: chartColor,
                          strokeWidth: 2,
                          strokeColor: theme.colorScheme.surface,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: chartColor.withOpacity(0.1),
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  enabled: true,
                  touchTooltipData: LineTouchTooltipData(
                    tooltipBgColor: theme.colorScheme.surface,
                    tooltipBorder: BorderSide(
                      color: theme.colorScheme.outline,
                      width: 1,
                    ),
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        return LineTooltipItem(
                          '${labels[touchedSpot.x.toInt()]}\n${touchedSpot.y.toStringAsFixed(1)}',
                          theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurface,
                          ) ?? TextStyle(color: theme.colorScheme.onSurface),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Pie chart widget for displaying proportions
class ShadPieChart extends StatelessWidget {
  const ShadPieChart({
    super.key,
    required this.data,
    required this.labels,
    this.title,
    this.height = 200,
    this.colors,
    this.showPercentage = true,
  });

  final List<double> data;
  final List<String> labels;
  final String? title;
  final double height;
  final List<Color>? colors;
  final bool showPercentage;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final total = data.reduce((a, b) => a + b);
    final defaultColors = [
      theme.colorScheme.primary,
      theme.colorScheme.secondary,
      Colors.orange,
      Colors.green,
      Colors.purple,
      Colors.teal,
      Colors.red,
      Colors.amber,
    ];

    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Text(
              title!,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
          ],
          SizedBox(
            height: height,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: PieChart(
                    PieChartData(
                      pieTouchData: PieTouchData(
                        touchCallback: (FlTouchEvent event, pieTouchResponse) {
                          // Handle touch events if needed
                        },
                      ),
                      borderData: FlBorderData(show: false),
                      sectionsSpace: 2,
                      centerSpaceRadius: 40,
                      sections: data.asMap().entries.map((entry) {
                        final index = entry.key;
                        final value = entry.value;
                        final percentage = (value / total) * 100;
                        
                        return PieChartSectionData(
                          color: colors?[index % (colors?.length ?? 1)] ?? 
                                 defaultColors[index % defaultColors.length],
                          value: value,
                          title: showPercentage 
                              ? '${percentage.toStringAsFixed(1)}%'
                              : value.toStringAsFixed(0),
                          radius: 60,
                          titleStyle: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          borderSide: BorderSide(
                            color: theme.colorScheme.surface,
                            width: 2,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: data.asMap().entries.map((entry) {
                      final index = entry.key;
                      final value = entry.value;
                      final percentage = (value / total) * 100;
                      final color = colors?[index % (colors?.length ?? 1)] ?? 
                                   defaultColors[index % defaultColors.length];
                      
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(2),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                labels[index],
                                style: theme.textTheme.bodySmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${percentage.toStringAsFixed(1)}%',
                              style: theme.textTheme.bodySmall?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Metric card widget for displaying key statistics
class ShadMetricCard extends StatelessWidget {
  const ShadMetricCard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.icon,
    this.color,
    this.trend,
    this.trendValue,
  });

  final String title;
  final String value;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final String? trend; // 'up', 'down', 'stable'
  final String? trendValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = color ?? theme.colorScheme.primary;

    return ShadCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: cardColor,
                  size: 20,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ),
              if (trend != null) ...[
                Icon(
                  trend == 'up' 
                      ? Icons.trending_up
                      : trend == 'down'
                          ? Icons.trending_down
                          : Icons.trending_flat,
                  color: trend == 'up' 
                      ? Colors.green
                      : trend == 'down'
                          ? Colors.red
                          : Colors.grey,
                  size: 16,
                ),
                if (trendValue != null) ...[
                  const SizedBox(width: 4),
                  Text(
                    trendValue!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: trend == 'up' 
                          ? Colors.green
                          : trend == 'down'
                              ? Colors.red
                              : Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ],
            ],
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: cardColor,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.6),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
