import 'package:image_picker/image_picker.dart';

mixin ImageMixin {
  ImagePicker imagePicker = ImagePicker();

  Future<XFile?> getSingleImageFromSource({ImageSource source = ImageSource.gallery}) async {
    XFile? image = await imagePicker.pickImage(source: source, imageQuality: 80);
    return image;
  }
}
