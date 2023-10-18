import 'dart:isolate';

// import 'package:dokit/kit/apm/log_kit.dart';
// import 'package:flutter_ume_kit_console/console/console_manager.dart';

Future<SendPort> _printPort = _printIsolate();

// 创建异步打印 isolate
void asyncPrint(Object? object) async {
  String line = "$object";
  // LogManager.instance.addLog(LogBean.TYPE_INFO, line);
  // ConsoleManager.streamController?.add(line);
  final print = await _printPort;
  print.send(line);
}

Future<SendPort> _printIsolate() async {
  // 定义接收工作Isolate消息端口
  ReceivePort workReceive = ReceivePort();
  SendPort workPort = workReceive.sendPort;

  await Isolate.spawn(_printWork, workPort);
  print("init async print isolate");
  SendPort msgPort = await workReceive.first;
  return msgPort;
}

// 处理打印任务
void _printWork(SendPort workPort) async {
  // 定义接收主Isolate消息端口
  ReceivePort msgReceive = ReceivePort();
  SendPort msgPort = msgReceive.sendPort;

  // 将新isolate中创建的SendPort发送到主isolate中用于通信
  workPort.send(msgPort);
  await msgReceive.listen((message) {
    // ignore: avoid_print
    print(message);
  }).asFuture();
}
