import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  Future<File?> pickImageFromGallery() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    return pickedImage != null ? File(pickedImage.path) : null;
  }
}
//สร้างmethood