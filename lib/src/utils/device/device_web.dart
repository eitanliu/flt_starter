import 'package:flt_starter/foundation/logcat.dart';
import 'package:ua_parser_js/ua_parser_js.dart';

import 'device.dart';
import 'device_sub.dart';

DeviceUtils createDevice() => DeviceUtilsWeb();

class DeviceUtilsWeb extends DeviceUtilsSub {
  final uaParser = UAParser();

  DeviceUtilsWeb() {
    final result = uaParser.getResult();
    logcat("UAParser: ${result.jsObject()}");
    //var major = js.JsObject(js.context["UAParser"]).callMethod("getResult")["browser"]["major"];
    //var major = UAParser().getResult().browser.major;
  }

  @override
  String get platform => uaParser.getOS().name;
}
