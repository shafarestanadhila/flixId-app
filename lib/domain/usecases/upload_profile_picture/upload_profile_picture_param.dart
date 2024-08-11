import 'dart:io';

import 'package:flix_id_app/domain/entities/user.dart';

class UploadProfilePictureParam{
  final File imageFile;
  final User user;

  UploadProfilePictureParam({required this.imageFile, required this.user});
}