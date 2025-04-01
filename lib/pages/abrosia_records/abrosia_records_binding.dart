import 'package:get/get.dart';

import 'abrosia_records_logic.dart';

class AbrosiaRecordsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AbrosiaRecordsLogic());
  }
}
