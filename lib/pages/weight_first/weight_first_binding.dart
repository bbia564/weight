import 'package:get/get.dart';

import 'weight_first_logic.dart';

class WeightFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeightFirstLogic());
  }
}
