import 'package:flix_id_app/data/repositories/transaction_repository.dart';
import 'package:flix_id_app/domain/entities/result.dart';
import 'package:flix_id_app/domain/entities/transaction.dart';
import 'package:flix_id_app/domain/usecases/create_transaction/create_transaction.dart';
import 'package:flix_id_app/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:flix_id_app/domain/usecases/top_up/top_up_param.dart';
import 'package:flix_id_app/domain/usecases/usecase.dart';

class TopUp implements Usecase<Result<void>, TopUpParam> {
  final TransactionRepository _transactionRepository;

  TopUp(
    {required TransactionRepository transactionRepository})
    : _transactionRepository = transactionRepository;

  @override
  Future<Result<void>> call(TopUpParam params) async {
    CreateTransaction createTransaction = CreateTransaction(transactionRepository: _transactionRepository);

  int transactionTime = DateTime.now().millisecondsSinceEpoch;

  var createTransactionResult = await createTransaction(CreateTransactionParam(transaction: 
  Transaction(
  id: 'flxtp-$transactionTime-${params.userId}',
    uid: params.userId, 
    title: 'Top Up',
    adminFee: 0, 
    totalPrice: -params.amount,
    transactionTime: transactionTime
  )));

  return switch(createTransactionResult){
    Success(value: _) => const Result.success(null),
    Failed(message: _) => Result.failed('failed to top up')
  };
  }
}