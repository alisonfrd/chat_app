import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/data/model/register_model.dart';

import 'package:flutter_chat/domain/models/user_model.dart';
import 'package:flutter_chat/utils/result.dart';

import '../services/register_client.dart';
import 'register_repository.dart';

class FirebaseRegisterRepository extends ChangeNotifier
    implements RegisterRepository {
  FirebaseRegisterRepository({required this.service});

  final RegisterClient service;

  @override
  Future<Result<RegisterModel>> createUser(UserModel user) async {
    try {
      final resultRegister = await service.createUser(user);

      return resultRegister;
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
