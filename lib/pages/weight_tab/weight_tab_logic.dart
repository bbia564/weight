import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:my_weight/db_weight/db_weight.dart';
import 'package:my_weight/main.dart';
import 'package:styled_widget/styled_widget.dart';

import '../../db_weight/weight_entity.dart';
import '../weight_first/weight_first_logic.dart';
import '../weight_second/weight_text_field.dart';

class WeightTabLogic extends GetxController {
  DBWeight dbWeight = Get.find();

  PageController pageController = PageController();
  var currentIndex = 0.obs;

  void checkNetwork() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      Get.toNamed('/reloadPage');
    }
  }

  addFastingRecordData(BuildContext context) async {
    DateTime? selectedTime;
    String selectedTimeStr = '';
    Get.dialog(GetBuilder<WeightTabLogic>(
        id: 'selectedTime',
        builder: (_) {
          return AlertDialog(
            title: const Text(
              'Fasting record',
              textAlign: TextAlign.center,
            ),
            content: Container(
              width: double.infinity,
              height: 50,
              child: <Widget>[
                Expanded(
                    child: IgnorePointer(
                  child: WeightTextField(
                      textAlign: TextAlign.center,
                      hintText: 'Select time',
                      value: selectedTimeStr,
                      onChange: (_) {}),
                )),
                const SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.calendar_month_sharp,
                  size: 25,
                  color: primaryColor,
                ).marginOnly(right: 12)
              ].toRow(),
            )
                .decorated(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.grey.shade300))
                .gestures(onTap: () {
              DatePicker.showDatePicker(context, dateFormat: 'HH:mm',
                  onConfirm: (date, list) {
                selectedTime = date;
                selectedTimeStr = DateFormat('HH:mm').format(date);
                update(['selectedTime']);
              });
            }),
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
                  final result = await dbWeight.getWeightAllData();
                  final lastWeight = result
                      .where((e) => e.type == 1)
                      .toList()
                      .firstWhereOrNull((e) =>
                          e.createdTime.year == selectedTime!.year &&
                          e.createdTime.month == selectedTime!.month &&
                          e.createdTime.day == selectedTime!.day);
                  if (lastWeight != null) {
                    await dbWeight.updateWeight(WeightEntity(
                        id: lastWeight.id,
                        createdTime: lastWeight.createdTime,
                        type: 1,
                        weight: '0',
                        fastingTime: selectedTime!));
                  } else {
                    await dbWeight.insertWeight(WeightEntity(
                        id: 0,
                        createdTime: DateTime.now(),
                        type: 1,
                        weight: '0',
                        fastingTime: selectedTime!));
                  }

                  WeightFirstLogic firstLogic = Get.put(WeightFirstLogic());
                  firstLogic.getData();
                  Get.back();
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        }));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    checkNetwork();
    super.onInit();
  }
}
