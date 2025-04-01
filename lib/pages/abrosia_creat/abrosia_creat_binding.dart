import 'package:get/get.dart';

import 'abrosia_creat_logic.dart';

class AbrosiaCreatBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      PageLogic(),
      permanent: true,
    );
  }
}
