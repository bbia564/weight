import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'weight_second_logic.dart';

class WeightSecondPage extends GetView<WeightSecondLogic> {
  Widget _item(int index, BuildContext context) {
    final titles = [
      'Fasting records',
      'Weight records',
      'Target weight',
      'Initial weight',
      'Clean all records',
    ];
    return Container(
      color: Colors.transparent,
      height: 40,
      child: <Widget>[
        Text(titles[index]),
        Visibility(
            visible: index < 4,
            child: const Icon(
              Icons.keyboard_arrow_right,
              size: 20,
              color: Colors.grey,
            )),
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).gestures(onTap: () {
      switch (index) {
        case 0:
          Get.toNamed('/abrosiaRecords');
          break;
        case 1:
          Get.toNamed('/weightRecords');
          break;
        case 2:
          controller.addWeightData();
          break;
        case 3:
          controller.addWeightData(isTarget: false);
          break;
        case 4:
          controller.cleanWeightData();
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            const Text(
              'Setting',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: <Widget>[_item(0, context), _item(1, context)].toColumn(
                  separator: Divider(
                height: 10,
                color: Colors.grey.shade300,
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: <Widget>[_item(2, context), _item(3, context)].toColumn(
                  separator: Divider(
                height: 10,
                color: Colors.grey.shade300,
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            const SizedBox(height: 15),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: <Widget>[_item(4, context),
                Container(
                  height: 40,
                  padding: const EdgeInsets.only(bottom: 10),
                  child: <Widget>[
                    const Text("About us"),
                    const Text("v1.0.0"),
                  ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                ),
              ].toColumn(
                  separator: Divider(
                height: 10,
                color: Colors.grey.shade300,
              )),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(15))
          ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
        ).marginAll(15)),
      ),
    );
  }
}
