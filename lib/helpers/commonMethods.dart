import 'package:image_picker/image_picker.dart';

import '../utils/showsnackbar.dart';

class CommonMethods {
  static String? userId;

  static var navigatorKey;

  static Future<XFile?> getImage(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    try {
      return await picker.pickImage(
        imageQuality: 35,
        source: imageSource,
      );

      // Otherwise open camera to get new photo
    } on Exception catch (e) {
      dp(msg: "Error in picking image", arg: e);
      return null;
    }
  }

  static Future<XFile?> getVideo(ImageSource imageSource) async {
    ImagePicker picker = ImagePicker();
    try {
      return await picker.pickVideo(
          // preferredCameraDevice: CameraDevice.,
          // imageQuality: 35,
          source: imageSource,
          maxDuration: Duration(hours: 1));

      // Otherwise open camera to get new photo
    } on Exception catch (e) {
      dp(msg: "Error in picking image", arg: e);
      return null;
    }
  }
}
