import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// 选择图片
Future<XFile?> imagePickerDialog<T>(
  BuildContext context, {
  double? maxWidth = 1920,
  double? maxHeight = 1920,
  int? imageQuality = 90,
  CameraDevice preferredCameraDevice = CameraDevice.rear,
}) async {
  final source = await showModalBottomSheet(
    context: context,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(10),
      ),
    ),
    builder: (_) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(ImageSource.camera);
                },
                child: const Text("拍照"),
              ),
            ),
            const Divider(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  Navigator.of(context).pop(ImageSource.gallery);
                },
                child: const Text("相册"),
              ),
            ),
            const Divider(height: 5, thickness: 5),
            SizedBox(
              width: double.infinity,
              // color: Colors.red,
              child: TextButton(
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "取消",
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );

  if (source == null) return null;
  final res = await ImagePicker().pickImage(
    source: source,
    maxWidth: maxHeight,
    maxHeight: maxHeight,
    imageQuality: imageQuality,
    preferredCameraDevice: preferredCameraDevice,
  );
  return res;
}
