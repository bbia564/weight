import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_weight/db_weight/db_weight.dart';
import 'package:my_weight/db_weight/weight_entity.dart';
import 'package:my_weight/pages/weight_second/weight_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

class WeightFirstLogic extends GetxController {
  DBWeight dbWeight = Get.find();

  var initialWeight = 0.0.obs;
  var targetWeight = 0.0.obs;
  var currentWeight = 0.0.obs;
  var weightList = <WeightEntity>[].obs;
  var fastingList = <WeightEntity>[].obs;
  double yMax = 0.0;

  void getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    initialWeight.value = prefs.getDouble('initial') ?? 0.0;
    targetWeight.value = prefs.getDouble('target') ?? 0.0;
    final weightResult = await dbWeight.getLast7DaysWeights();
    final fastResult = await dbWeight.getWeightAllData();
    weightList.value = weightResult.where((e) => e.type == 0).toList();
    fastingList.value = fastResult.where((e) => e.type == 1).toList();
    currentWeight.value = double.parse(weightList.value.last.weight);
    yMax = weightList.value
            .map((e) => double.parse(e.weight))
            .reduce((value, element) => value > element ? value : element) +
        10;
    update();
  }

  addCurrentWeightData() async {
    var title = '';
    Get.dialog(AlertDialog(
      title: const Text(
        'Current Weight',
        textAlign: TextAlign.center,
      ),
      content: Container(
        width: double.infinity,
        height: 50,
        child: WeightTextField(
            maxLength: 3,
            isNumber: true,
            textAlign: TextAlign.center,
            value: title,
            onChange: (v) {
              title = v;
            }),
      ).decorated(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300)),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black45),
          ),
        ),
        TextButton(
          onPressed: () async {
            double weight = double.tryParse(title) ?? 0.0;
            if (weight <= 0) {
              Fluttertoast.showToast(msg: 'Please enter a valid weight.');
              return;
            }
            if (weight > 500) {
              Fluttertoast.showToast(msg: 'Please enter a valid weight.');
              return;
            }
            if (weight > 0) {
              final result = await dbWeight.getLast7DaysWeights();
              final now = DateTime.now();
              var lastWeight = result.firstWhereOrNull((e) =>
                  e.createdTime.year == now.year &&
                  e.createdTime.month == now.month &&
                  e.createdTime.day == now.day);
              if (lastWeight != null) {
                await dbWeight.updateWeight(WeightEntity(
                    id: lastWeight.id,
                    createdTime: lastWeight.createdTime,
                    type: 0,
                    weight: weight.toString(),
                    fastingTime: lastWeight.fastingTime));
              } else {
                await dbWeight.insertWeight(WeightEntity(
                    id: 0,
                    createdTime: now,
                    type: 0,
                    weight: weight.toString(),
                    fastingTime: now));
              }
            }
            getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }
}
