import 'package:flix_id_app/data/repositories/user_repositry.dart';
import 'package:flix_id_app/domain/entities/result.dart';
import 'package:flix_id_app/domain/entities/user.dart';
import 'package:flix_id_app/domain/usecases/upload_profile_picture/upload_profile_picture_param.dart';
import 'package:flix_id_app/domain/usecases/usecase.dart';

class UploadProfilePicture implements Usecase<Result<User>, UploadProfilePictureParam> {
  final UserRepository _userRepository;

  UploadProfilePicture({required UserRepository userRepository})
    : _userRepository = userRepository;
  
  @override
  Future<Result<User>> call(UploadProfilePictureParam params) => 
    _userRepository.uploadProfilepicture(user: params.user, imageFile: params.imageFile);
}