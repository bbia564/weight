import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_weight/db_weight/db_weight.dart';
import 'package:my_weight/pages/abrosia_records/abrosia_records_binding.dart';
import 'package:my_weight/pages/abrosia_records/abrosia_records_view.dart';
import 'package:my_weight/pages/reload_page/reload_page_binding.dart';
import 'package:my_weight/pages/reload_page/reload_page_view.dart';
import 'package:my_weight/pages/weight_first/weight_first_binding.dart';
import 'package:my_weight/pages/weight_first/weight_first_view.dart';
import 'package:my_weight/pages/weight_records/weight_records_binding.dart';
import 'package:my_weight/pages/weight_records/weight_records_view.dart';
import 'package:my_weight/pages/weight_second/weight_second_binding.dart';
import 'package:my_weight/pages/weight_second/weight_second_view.dart';
import 'package:my_weight/pages/weight_tab/weight_tab_binding.dart';
import 'package:my_weight/pages/weight_tab/weight_tab_view.dart';

Color primaryColor = const Color(0xff3277fa);
Color bgColor = const Color(0xfff0f1f5);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => DBWeight().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Weights,
      initialRoute: '/weightTab',
      theme: ThemeData(
        useMaterial3: true,
        primaryColor: primaryColor,
        scaffoldBackgroundColor: bgColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          scrolledUnderElevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: primaryColor,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        cardTheme: const CardTheme(
          color: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
        ),
        dialogTheme: const DialogTheme(
          actionsPadding: EdgeInsets.only(right: 10, bottom: 5),
        ),
        dividerTheme: DividerThemeData(
          thickness: 1,
          color: Colors.grey[200],
        ),
      ),
    );
  }
}
List<GetPage<dynamic>> Weights = [
  GetPage(name: '/reloadPage', page: () => ReloadPageView(), binding: ReloadPageBinding()),
  GetPage(name: '/weightFirst', page: () => WeightFirstPage(), binding: WeightFirstBinding()),
  GetPage(name: '/weightSecond', page: () => WeightSecondPage(), binding: WeightSecondBinding()),
  GetPage(name: '/weightTab', page: () => WeightTabPage(), binding: WeightTabBinding()),
  GetPage(name: '/weightRecords', page: () => WeightRecordsPage(), binding: WeightRecordsBinding()),
  GetPage(name: '/abrosiaRecords', page: () => AbrosiaRecordsPage(), binding: AbrosiaRecordsBinding()),
];