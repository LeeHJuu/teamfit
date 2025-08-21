import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'services/user_service.dart';

final _firestore = FirebaseFirestore.instance;

final userServiceProvider = Provider<UserService>((ref) {
  return UserService(_firestore);
});
