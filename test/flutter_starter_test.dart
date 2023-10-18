import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_starter/flutter_starter.dart';
import 'package:flutter_starter/flutter_starter_platform_interface.dart';
import 'package:flutter_starter/flutter_starter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterStarterPlatform
    with MockPlatformInterfaceMixin
    implements FlutterStarterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterStarterPlatform initialPlatform = FlutterStarterPlatform.instance;

  test('$MethodChannelFlutterStarter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterStarter>());
  });

  test('getPlatformVersion', () async {
    FlutterStarter flutterStarterPlugin = FlutterStarter();
    MockFlutterStarterPlatform fakePlatform = MockFlutterStarterPlatform();
    FlutterStarterPlatform.instance = fakePlatform;

    expect(await flutterStarterPlugin.getPlatformVersion(), '42');
  });
}
