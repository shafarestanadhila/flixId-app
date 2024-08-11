import 'package:flix_id_app/data/firebase/firebase_user_repository.dart';
import 'package:flix_id_app/data/repositories/user_repositry.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(UserRepositoryRef ref) =>
  FirebaseUserRepository();