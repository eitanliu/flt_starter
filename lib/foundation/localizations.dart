import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// Desc:  多语言适配
/// <p>
/// Date: 4/20/21
/// Copyright: Copyright (c) 2010-2021
/// Updater:
/// Update Time:
/// Update Comments:
/// Param [T]  外部多语言 S 对象
///

/// 装载全局上下文
late BuildContext localizationsContext;

T l10nOf<T>([BuildContext? context]) {
  final instance = l10nMaybeOf(context);
  assert(instance != null, 'No instance of $T present in widget tree.');
  return instance as T;
}

T? l10nMaybeOf<T>([BuildContext? context]) {
  final instance = Localizations.of<T>(context ?? localizationsContext, T);
  return instance;
}

GenerateAppTitle initLocalizationsTitle(
  GenerateAppTitle builder,
) {
  return (BuildContext context) {
    localizationsContext = context;
    return builder(context);
  };
}

TransitionBuilder initLocalizationsWidget(
  TransitionBuilder builder,
) {
  return (BuildContext context, Widget? child) {
    localizationsContext = context;
    return builder(context, child);
  };
}
