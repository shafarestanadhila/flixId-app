import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flix_id_app/data/firebase/firebase_user_repository.dart';
import 'package:flix_id_app/data/repositories/transaction_repository.dart';
import 'package:flix_id_app/domain/entities/result.dart';
import 'package:flix_id_app/domain/entities/transaction.dart';

class FirebaseTransactionRepository implements TransactionRepository{

  final firestore.FirebaseFirestore _firebaseFirestore;

  FirebaseTransactionRepository(
    {firestore.FirebaseFirestore? firebaseFireStore})
    : _firebaseFirestore =
        firebaseFireStore ?? firestore.FirebaseFirestore.instance;
    
  @override
  Future<Result<Transaction>> createTransaction({required Transaction transaction}) async {
    firestore.CollectionReference<Map<String, dynamic>> transactions = _firebaseFirestore.collection('transactions');

    try {
      var balanceResult = await FirebaseUserRepository().getUserBalance(uid: transaction.uid);
      if (balanceResult.isSuccess) {
        int previousBalance = balanceResult.resultValue!;

        if (previousBalance >= transaction.totalPrice) {
          await transactions.doc(transaction.id).set(transaction.toJson());

          var result = await transactions.doc(transaction.id).get();

          if (result.exists) {
            await FirebaseUserRepository().updateUserBalance(uid: transaction.uid, balance: previousBalance - transaction.totalPrice);
            return Result.success(transaction);
          } else {
            return const Result.failed('Failed to create transaction data');
          }
        } else {
          return const Result.failed('Insufficient balance');
        }
      } else {
        return const Result.failed('Failed to retrieve user balance');
      }
    } catch (e) {
      return Result.failed('Failed to create transaction data: $e');
    }
  }

  @override
  Future<Result<List<Transaction>>> getUserTranasaction({required String uid}) async {
    firestore.CollectionReference<Map<String, dynamic>> transactions =
      _firebaseFirestore.collection('transactions');

    try{
      var result = await transactions.where('uid', isEqualTo: uid).get();
      if(result.docs.isNotEmpty){
        return Result.success(result.docs
          .map((e)=>Transaction.fromJson(e.data()))
          .toList()
        );
      }else{
        return const Result.success([]);
      }
    } catch(e){
      return const Result.failed('Failed to get user transactions');
    }
  }
}