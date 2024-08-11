import 'package:flix_id_app/data/repositories/user_repositry.dart';
import 'package:flix_id_app/domain/entities/result.dart';
import 'package:flix_id_app/domain/usecases/get_user_balance/get_user_balance_param.dart';
import 'package:flix_id_app/domain/usecases/usecase.dart';

class GetUserBalance implements Usecase<Result<int>, GetUserBalanceParam>{
  final UserRepository _userRepository;

  GetUserBalance({required UserRepository userRepository})
  : _userRepository = userRepository;

  @override
  Future<Result<int>> call(GetUserBalanceParam params) => _userRepository.getUserBalance(uid: params.userId);
}