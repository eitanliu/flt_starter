// import 'package:flutter_starter/flutter_starter.dart';
// import 'package:flutter_starter/utils/logcat.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// // typedef RebuildFactor = bool Function(MediaQueryData old, MediaQueryData data);
//
// class MediaQueryBuilder extends SingleChildStatefulWidget {
//   final RebuildFactor rebuildFactor;
//   final TransitionBuilder builder;
//
//   const MediaQueryBuilder({
//     Key? key,
//     this.rebuildFactor = RebuildFactors.size,
//     Widget? child,
//     required this.builder,
//   }) : super(key: key, child: child);
//
//   @override
//   SingleChildState<MediaQueryBuilder> createState() =>
//       _MediaQueryBuilderState();
// }
//
// class _MediaQueryBuilderState extends SingleChildState<MediaQueryBuilder> {
//   MediaQueryData? value;
//   Widget? cache;
//
//   @override
//   Widget buildWithChild(BuildContext context, Widget? child) {
//     final data = MediaQuery.maybeOf(context);
//     final old = value;
//     final shouldInvalidateCache =
//         old == null || data == null || widget.rebuildFactor(old, data);
//     // logcat("MediaQuery old $old");
//     // logcat("MediaQuery now $shouldInvalidateCache, $data");
//     if (shouldInvalidateCache) {
//       value = data;
//       cache = widget.builder(context, child);
//     }
//     return cache!;
//   }
// }
