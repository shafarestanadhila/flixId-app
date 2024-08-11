import 'package:flix_id_app/domain/entities/result.dart';
import 'package:flix_id_app/domain/entities/transaction.dart';

abstract interface class TransactionRepository {
  Future<Result<Transaction>> createTransaction(
    {
      required Transaction transaction
    }
  );

  Future<Result<List<Transaction>>> getUserTranasaction(
    {
      required String uid
    }
  );
}