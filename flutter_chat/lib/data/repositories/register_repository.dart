import 'package:flutter_chat/domain/models/user_model.dart';
import 'package:flutter_chat/utils/result.dart';

import '../model/register_model.dart';

abstract class RegisterRepository {
  Future<Result<RegisterModel>> createUser(UserModel user);
}
