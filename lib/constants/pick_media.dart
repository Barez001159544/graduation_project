import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';

File? file=null;
List<int>? imageBytes;
String? encodedImage;
Future pickImage() async{
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

  if (result != null) {
    file = File(result.files.single.path!);
    // Read the image file as bytes
    imageBytes = await file!.readAsBytes();
    // Encode image bytes as Base64
    encodedImage = base64.encode(imageBytes!);
    print(file);
  } else {
    // User canceled the picker
  }
}

Future pickFile() async{
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    file = File(result.files.single.path!);
  } else {
    // User canceled the picker
  }
}