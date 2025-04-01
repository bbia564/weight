import 'package:get/get.dart';

import '../weight_first/weight_first_logic.dart';
import '../weight_second/weight_second_logic.dart';
import 'weight_tab_logic.dart';

class WeightTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WeightTabLogic());
    Get.lazyPut(() => WeightFirstLogic());
    Get.lazyPut(() => WeightSecondLogic());
  }
}
