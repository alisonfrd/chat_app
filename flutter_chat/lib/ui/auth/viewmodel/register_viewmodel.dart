import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat/domain/models/user_model.dart';
import 'package:flutter_chat/utils/utils.dart';

import '../../../data/model/register_model.dart';
import '../../../data/repositories/remote_register_repository.dart';

class RegisterViewModel extends ChangeNotifier {
  RegisterViewModel({required FirebaseRegisterRepository repository})
    : _repository = repository {
    createCommand = Command1(_register);
  }
  final FirebaseRegisterRepository _repository;

  late Command1<UserCredential, UserModel> createCommand;

  UserCredential? _credential;

  UserCredential? get credential => _credential;

  Future<Result<UserCredential>> _register(UserModel user) async {
    final resultCreate = await _repository.createUser(user);

    if (resultCreate is Ok<RegisterModel>) {
      _credential = (resultCreate.value as FirebaseRegisterModel).credential;
      notifyListeners();
      return Result.ok(_credential!);
    } else {
      print(resultCreate);
      return Result.error((resultCreate as Error).error);
    }
  }
}
