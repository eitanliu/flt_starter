import 'package:flutter/material.dart';

///
///  MaterialStateProperty的状态
///
extension MaterialStatePropertyExtension<T> on MaterialStateProperty<T> {
  T get(MaterialState state) => resolve({state});
}
