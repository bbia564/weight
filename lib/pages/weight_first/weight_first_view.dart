import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_weight/main.dart';
import 'package:styled_widget/styled_widget.dart';

import 'weight_first_logic.dart';

class WeightFirstPage extends GetView<WeightFirstLogic> {
  List<Color> gradientColors = [
    const Color(0xff3277fa).withOpacity(0.2),
    const Color(0xff3277fa).withOpacity(0),
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontSize: 12,
    );
    String text = controller.weightList[value.toInt()].createdTimeChartStr;

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.grey,
      fontSize: 12,
    );
    String text = value.toString();

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: primaryColor,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: primaryColor,
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
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 40,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 42,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: true,
        border: const Border(
            left: BorderSide(color: Color(0xff37434d)),
            bottom: BorderSide(color: Color(0xff37434d))),
      ),
      minX: 0,
      maxX: controller.weightList.value.length.toDouble() - 1,
      minY: 0,
      maxY: controller.yMax,
      lineBarsData: [
        LineChartBarData(
          spots: List.generate(controller.weightList.value.length, (i) {
            var item = controller.weightList.value[i];
            return FlSpot(i.toDouble(), double.parse(item.weight));
          }),
          isCurved: true,
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors.map((color) => color).toList(),
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: GetBuilder<WeightFirstLogic>(
                init: WeightFirstLogic(),
                builder: (_) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: <Widget>[
                      const Text(
                        'Home',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: <Widget>[
                          <Widget>[
                            const Text(
                              'My weight',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            <Widget>[
                              Obx(() {
                                return Text(
                                    '${controller.currentWeight.value}kg',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold));
                              }),
                              const SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                'assets/icon.webp',
                                width: 15,
                                height: 15,
                                fit: BoxFit.cover,
                              )
                            ]
                                .toRow(mainAxisAlignment: MainAxisAlignment.end)
                                .gestures(onTap: () {
                              controller.addCurrentWeightData();
                            })
                          ].toRow(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween),
                          <Widget>[
                            Container(
                              width: double.infinity,
                              height: 9,
                            ).decorated(
                                color: const Color(0xffdcdef0),
                                borderRadius: BorderRadius.circular(4.5)),
                            LayoutBuilder(builder: (_, max) {
                              return Container(
                                width: (controller.initialWeight.value -
                                            controller.currentWeight.value) <=
                                        0
                                    ? 0
                                    : (max.maxWidth *
                                            ((controller.currentWeight.value -
                                                        controller.targetWeight
                                                            .value) <=
                                                    0
                                                ? max.maxWidth
                                                : ((controller.initialWeight
                                                            .value -
                                                        controller.targetWeight
                                                            .value) -
                                                    (controller.currentWeight
                                                            .value -
                                                        controller.targetWeight
                                                            .value)))) /
                                        (controller.initialWeight.value -
                                            controller.targetWeight.value),
                                height: 9,
                              ).decorated(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(4.5));
                            })
                          ].toStack().marginSymmetric(vertical: 6),
                          <Widget>[
                            Obx(() {
                              return Text(
                                'Initial: ${controller.initialWeight.value}kg',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              );
                            }),
                            Obx(() {
                              return Text(
                                'Target: ${controller.targetWeight.value}kg',
                                style: const TextStyle(
                                    color: Colors.grey, fontSize: 12),
                              );
                            })
                          ].toRow(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween)
                        ].toColumn(),
                      ).decorated(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        child: <Widget>[
                          <Widget>[
                            const Text(
                              'Visual weight',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'More',
                              style: TextStyle(color: Colors.grey),
                            ).gestures(onTap: () {
                              Get.toNamed('/weightRecords');
                            }),
                          ].toRow(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            height: 200,
                            child: controller.weightList.value.isEmpty
                                ? const Center(
                                    child: Text('No data'),
                                  )
                                : IgnorePointer(
                                    child: LineChart(
                                      mainData(),
                                    ),
                                  ),
                          )
                        ].toColumn(),
                      ).decorated(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      const SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(12),
                        child: <Widget>[
                          <Widget>[
                            const Text(
                              'Fasting record',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              'More',
                              style: TextStyle(color: Colors.grey),
                            ).gestures(onTap: () {
                              Get.toNamed('/abrosiaRecords');
                            }),
                          ].toRow(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween),
                          Divider(
                            height: 20,
                            color: Colors.grey.shade300,
                          ),
                          Obx(() {
                            return controller.fastingList.value.isEmpty
                                ? const Center(
                                    child: Text('No data'),
                                  )
                                : ListView.builder(
                                    shrinkWrap: true,
                                    itemCount:
                                        controller.fastingList.value.length,
                                    itemBuilder: (_, index) {
                                      final entity =
                                          controller.fastingList.value[index];
                                      return <Widget>[
                                        <Widget>[
                                          Text(
                                            entity.createdTimeStr,
                                            style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                          Text(entity.fastingTimeStr)
                                        ].toRow(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween),
                                        Divider(
                                            height: 25,
                                            color: Colors.grey.shade300)
                                      ].toColumn();
                                    });
                          })
                        ].toColumn(),
                      ).decorated(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15))
                    ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
                  );
                }).marginAll(15)),
      ),
    );
  }
}
