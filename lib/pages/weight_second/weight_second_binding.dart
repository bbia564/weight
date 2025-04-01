import 'package:get/get.dart';

import 'weight_second_logic.dart';

class WeightSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeightSecondLogic());
  }
}
