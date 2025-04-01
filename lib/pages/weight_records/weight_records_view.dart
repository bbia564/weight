import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'weight_records_logic.dart';

class WeightRecordsPage extends GetView<WeightRecordsLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weight Records'),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            padding:const EdgeInsets.all(15),
            child: Obx(() {
              return controller.list.value.isEmpty
                  ? const Center(
                child: Text('No data'),
              )
                  : ListView.builder(
                  itemCount:
                  controller.list.value.length,
                  itemBuilder: (_, index) {
                    final entity =
                    controller.list.value[index];
                    return <Widget>[
                      <Widget>[
                        Text(
                          entity.createdTimeStr,
                          style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey),
                        ),
                        Text('${entity.weight} kg')
                      ].toRow(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween),
                      Divider(
                          height: 25,
                          color: Colors.grey.shade300)
                    ].toColumn();
                  });
            }),
          )
              .decorated(
              color: Colors.white, borderRadius: BorderRadius.circular(15))
              .marginAll(15)),
    );
  }
}
