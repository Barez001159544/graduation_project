import 'dart:io';

import 'package:file_picker/file_picker.dart';

File? file=null;
Future pickImage() async{
  FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

  if (result != null) {
    file = File(result.files.single.path!);
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