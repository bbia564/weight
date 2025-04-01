import 'package:get/get.dart';

import 'reload_page_logic.dart';

class ReloadPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => NoNetworkLogic());
  }
}
