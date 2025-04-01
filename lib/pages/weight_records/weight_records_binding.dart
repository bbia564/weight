import 'package:get/get.dart';

import 'weight_records_logic.dart';

class WeightRecordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeightRecordsLogic());
  }
}
