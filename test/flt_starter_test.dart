import 'package:flutter_test/flutter_test.dart';
import 'package:flt_starter/flt_starter.dart';
import 'package:flt_starter/flt_starter_platform_interface.dart';
import 'package:flt_starter/flt_starter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFltStarterPlatform
    with MockPlatformInterfaceMixin
    implements FltStarterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FltStarterPlatform initialPlatform = FltStarterPlatform.instance;

  test('$MethodChannelFltStarter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFltStarter>());
  });

  test('getPlatformVersion', () async {
    FltStarter fltStarterPlugin = FltStarter();
    MockFltStarterPlatform fakePlatform = MockFltStarterPlatform();
    FltStarterPlatform.instance = fakePlatform;

    expect(await fltStarterPlugin.getPlatformVersion(), '42');
  });
}
