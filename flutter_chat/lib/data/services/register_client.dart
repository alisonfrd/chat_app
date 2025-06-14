import 'package:flutter_chat/data/model/register_model.dart';
import 'package:flutter_chat/domain/models/models.dart';

import '../../utils/result.dart';

abstract class RegisterClient {
  Future<Result<RegisterModel>> createUser(UserModel model);
}
