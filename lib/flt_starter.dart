import 'flt_starter_platform_interface.dart';

export 'package:flutter_screenutil/flutter_screenutil.dart';
export 'package:injectable/injectable.dart' hide test;

export 'binding.dart';
export 'extension.dart';
export 'foundation.dart';
export 'framework.dart';
export 'widget.dart';
class FltStarter {
  Future<String?> getPlatformVersion() {
    return FltStarterPlatform.instance.getPlatformVersion();
  }
}
