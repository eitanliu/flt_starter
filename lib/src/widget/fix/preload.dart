import 'package:flutter/widgets.dart';
import 'package:nested/nested.dart';

///
/// Web 预加载图片避免抖动
///
class PreloadAssetImages extends SingleChildStatelessWidget {
  final List<AssetImage> assets;

  const PreloadAssetImages({
    Key? key,
    List<AssetImage>? assets,
    Widget? child,
  })  : assets = assets ?? const [],
        super(key: key, child: child);

  @override
  Widget buildWithChild(BuildContext context, Widget? child) {
    for (var asset in assets) {
      ResizeImage.resizeIfNeeded(null, null, asset)
          .resolve(createLocalImageConfiguration(context));
    }
    return child ?? const SizedBox();
  }
}
