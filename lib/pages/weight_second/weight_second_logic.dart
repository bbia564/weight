import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:my_weight/db_weight/weight_entity.dart';
import 'package:my_weight/pages/weight_first/weight_first_logic.dart';
import 'package:my_weight/pages/weight_second/weight_text_field.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../db_weight/db_weight.dart';

class WeightSecondLogic extends GetxController {

  DBWeight dbWeight = Get.find();

  addWeightData({bool isTarget = true}) async {
    var title = '';
    Get.dialog(AlertDialog(
      title: Text(
        isTarget ? 'Target weight' : 'Initial Weight',
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
            final SharedPreferences prefs = await SharedPreferences.getInstance();
            if (isTarget) {
              final initialWeight = prefs.getDouble('initial') ?? 0.0;
              if (weight >= initialWeight) {
                Fluttertoast.showToast(msg: 'Please enter a valid weight.');
                return;
              }
              await prefs.setDouble('target', weight);
            } else {
              final targetWeight = prefs.getDouble('target') ?? 0.0;
              if (weight <= targetWeight) {
                Fluttertoast.showToast(msg: 'Please enter a valid weight.');
                return;
              }
              await prefs.setDouble('initial', weight);
            }
            WeightFirstLogic firstLogic = Get.put(WeightFirstLogic());
            firstLogic.getData();
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

  cleanWeightData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text('Cancel', style: TextStyle(color: Colors.black),),
        ),
        TextButton(
          onPressed: () async {
            await dbWeight.cleanWeightData();
            final SharedPreferences prefs = await SharedPreferences
                .getInstance();
            final initialWeight = prefs.getDouble('initial') ?? 0.0;
            await dbWeight.insertWeight(WeightEntity(id: 0,
                createdTime: DateTime.now(),
                type: 0,
                weight: initialWeight.toString(),
                fastingTime: DateTime.now()));
            WeightFirstLogic firstLogic = Get.put(WeightFirstLogic());
            firstLogic.getData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  aboutWeightUS(BuildContext context) async {
    var info = await PackageInfo.fromPlatform();
    showAboutDialog(
      applicationName: info.appName,
      applicationVersion: info.version,
      applicationIcon: Image.asset(
        'assets/launcher.webp',
        width: 77,
        height: 77,
      ),
      children: [
        const Text(
            """We can record your weight change"""),
      ],
      context: context,
    );
  }


}
