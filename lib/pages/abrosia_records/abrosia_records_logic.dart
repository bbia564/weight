import 'package:get/get.dart';
import 'package:my_weight/db_weight/db_weight.dart';
import 'package:my_weight/db_weight/weight_entity.dart';

class AbrosiaRecordsLogic extends GetxController {

  DBWeight dbWeight = Get.find();

  var list = <WeightEntity>[].obs;

  void getData() async {
    final result = await dbWeight.getWeightAllData();
    list.value = result.where((e) => e.type == 1).toList();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getData();
    super.onInit();
  }

}
