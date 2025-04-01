import 'package:get/get.dart';

import '../../db_weight/db_weight.dart';
import '../../db_weight/weight_entity.dart';

class WeightRecordsLogic extends GetxController {

  DBWeight dbWeight = Get.find();

  var list = <WeightEntity>[].obs;

  void getData() async {
    final result = await dbWeight.getWeightAllData();
    list.value = result.where((e) => e.type == 0).toList();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
