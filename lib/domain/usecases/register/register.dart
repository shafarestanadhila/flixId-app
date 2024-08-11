import 'package:flix_id_app/data/repositories/authentication.dart';
import 'package:flix_id_app/data/repositories/user_repositry.dart';
import 'package:flix_id_app/domain/entities/result.dart';
import 'package:flix_id_app/domain/entities/user.dart';
import 'package:flix_id_app/domain/usecases/register/register_params.dart';
import 'package:flix_id_app/domain/usecases/usecase.dart';

class Register implements Usecase<Result<User>, RegisterParams> {
  final Authentication _authentication;
  final UserRepository _userRepository;

  Register(
    {required Authentication authentication, 
    required UserRepository userRepository})
    : _authentication = authentication, 
      _userRepository = userRepository;

  @override
  Future<Result<User>> call(RegisterParams params) async {
    var uidResult = await _authentication.register(
      email: params.email, 
      password: params.password
    );

    if(uidResult.isSuccess){
      var userResult = await _userRepository.createUser(
        uid: uidResult.resultValue!, email: params.email, name: params.name,
        photoUrl: params.photoUrl
      );
      if(userResult.isSuccess){
        return Result.success(userResult.resultValue!);
      }else{
        return Result.failed(userResult.errorMessage!);
      }
    }else{
      return Result.failed(uidResult.errorMessage!);
    }
  }
}