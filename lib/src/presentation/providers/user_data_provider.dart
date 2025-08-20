import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/data/datasources/user_data_source.dart';
import 'package:teamfit/src/data/datasources/user_data_source_impl.dart';
import 'package:teamfit/src/data/repositories/user_repository_impl.dart';
import 'package:teamfit/src/domain/repositories/user_repository.dart';
import 'package:teamfit/src/domain/usecases/user_data_usecase.dart';

final _firestore = FirebaseFirestore.instance;

final _userDataSourceProvider = Provider<UserDataSource>((ref) {
  return UserDataSourceImpl(_firestore);
});

final _userRepositoryProvider = Provider<UserRepository>((ref) {
  final dataSource = ref.read(_userDataSourceProvider);
  return UserRepositoryImpl(dataSource);
});

final userDataUsecaseProvider = Provider<UserDataUsecase>((ref) {
  final userRepo = ref.read(_userRepositoryProvider);
  return UserDataUsecase(userRepo);
});
