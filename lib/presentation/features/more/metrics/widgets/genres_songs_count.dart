import 'package:animate_do/animate_do.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import '/presentation/features/more/metrics/models/genre_song_count_model.dart';
import '/presentation/widgets/loaders.dart';
import '/services/metrics_service.dart';
import '/utils/utils.dart';

class GenresSongsCountChart extends StatefulWidget {
  const GenresSongsCountChart({super.key});

  @override
  State<GenresSongsCountChart> createState() => _GenresSongsCountChartState();
}

class _GenresSongsCountChartState extends State<GenresSongsCountChart> {

  

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    final gradientColors = [
      theme.colorScheme.primary,
      Colors.yellow,
    ];

    final metricsService = Injector.appInstance.get<MetricsService>();
  
    return FadeInRight(
      child: FutureBuilder(

        future: metricsService.songCountByGenre(),
        builder: (context, snapshot) {

          if(snapshot.connectionState == ConnectionState.waiting){
            return const SizedBox(
              height: 200,
              child: LoadingWidget(),
            );
          }

          if(snapshot.data!.isFailed){
            return const Text('Error');
          }

          final resp = snapshot.data!.model!;
          
          return Stack(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1.70,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 18,
                    left: 12,
                    top: Sizes.kPadding,
                    bottom: 12,
                  ),
                  child: LineChart(
                    mainData(gradientColors, resp),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  LineChartData mainData(List<Color> colors, GenresSongCountResp data) {
    return LineChartData(
      
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: data.maxValue / 4.round(),
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white10,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white10,
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
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: (value, meta) => bottomTitleWidgets(value, meta, data),
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: data.inrtervals,
            getTitlesWidget: (value, meta) => leftTitleWidgets(value, meta, data),
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: Border.all(color: const Color(0xff37434d)),
      ),
      minX: 0,
      maxX: 12,
      minY: 0,
      maxY: data.maxValue,
      lineBarsData: [
        LineChartBarData(
          spots: [
            const FlSpot(0, 0),
            FlSpot(2, data.data[0].count),
            FlSpot(6, data.data.length <= 1 ? 0 : data.data[1].count),
            FlSpot(10, data.data.length <= 2 ? 0 : data.data[2].count),
            const FlSpot(12, 0),
          ],
          isCurved: true,
          gradient: LinearGradient(
            colors: colors,
          ),
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: colors
                  .map((color) => color.withOpacity(0.3))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta, GenresSongCountResp data) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 15,
    );

    return Text(value.toStringAsFixed(1), style: style, textAlign: TextAlign.left);
      
    
    
    
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta, GenresSongCountResp data) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 16,
    );
    Widget text;
    switch (value.toInt()) {
      case 2:
        text = Text(
          data.data[0].genre, style: style,
          overflow: TextOverflow.ellipsis,
        );
        break;
      case 6:
        text =  Text(
          data.data[1].genre, style: style,
          overflow: TextOverflow.ellipsis,
        );
        break;
      case 10:
        text = Text(
          data.data[2].genre, style: style,
          overflow: TextOverflow.ellipsis,
        );
        break;
      default:
        text = const Text('', style: style);
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text,
    );
  }
}