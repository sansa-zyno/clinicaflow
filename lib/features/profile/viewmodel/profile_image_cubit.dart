import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileImageCubit extends Cubit<File?> {
  ProfileImageCubit() : super(null);

  /* File? img;
  void setImage(File file) {
    img = file;
    emit(img);
  }*/
}
