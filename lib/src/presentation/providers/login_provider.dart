import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teamfit/src/data/datasources/login_data_source.dart';
import 'package:teamfit/src/data/datasources/login_data_source_impl.dart';
import 'package:teamfit/src/data/repositories/login_repository_impl.dart';
import 'package:teamfit/src/domain/repositories/login_repository.dart';
import 'package:teamfit/src/domain/usecases/user_data_usecase.dart';

final _firestore = FirebaseFirestore.instance;

final _loginDataSourceProvider = Provider<LoginDataSource>((ref) {
  return LoginDataSourceImpl(_firestore);
});

final _loginRepositoryProvider = Provider<LoginRepository>((ref) {
  final dataSource = ref.read(_loginDataSourceProvider);
  return LoginRepositoryImpl(dataSource);
});

final userDataUsecaseProvider = Provider<UserDataUsecase>((ref) {
  final userRepo = ref.read(_loginRepositoryProvider);
  return UserDataUsecase(userRepo);
});
