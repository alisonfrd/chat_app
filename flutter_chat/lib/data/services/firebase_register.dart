import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat/data/model/register_model.dart';
import 'package:flutter_chat/data/services/register_client.dart';
import 'package:flutter_chat/domain/models/user_model.dart';
import 'package:flutter_chat/utils/result.dart';

class FirebaseRegister implements RegisterClient {
  FirebaseRegister();

  @override
  Future<Result<FirebaseRegisterModel>> createUser(UserModel model) async {
    try {
      // await Future.delayed(Duration(seconds: 5));
      final instance = FirebaseAuth.instance;

      final credential = await instance.createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      return Result.ok(FirebaseRegisterModel(credential));
    } on FirebaseAuthException catch (e) {
      return Result.error(e);
    } on Exception catch (e) {
      print(e);
      return Result.error(e);
    }
  }
}
