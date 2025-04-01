import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_weight/pages/weight_first/weight_first_view.dart';
import 'package:my_weight/pages/weight_second/weight_second_view.dart';

import '../../main.dart';
import 'weight_tab_logic.dart';

class WeightTabPage extends GetView<WeightTabLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          WeightFirstPage(),
          WeightSecondPage()
        ],
      ),
      bottomNavigationBar: Obx(()=>_navWeBars(context)),
    );
  }

  Widget _navWeBars(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_filled,color: Colors.grey.withOpacity(0.6)),
          activeIcon:Icon(Icons.home_filled,color: primaryColor),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_circle,color: primaryColor,size: 40,),
          label: '',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings,color: Colors.grey.withOpacity(0.6)),
          activeIcon:Icon(Icons.settings,color: primaryColor),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        if (index == 1) {
          controller.addFastingRecordData(context);
        } else {
          controller.currentIndex.value = index;
          controller.pageController.jumpToPage(index);
        }
      },
    );
  }
}
