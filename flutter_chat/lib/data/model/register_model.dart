import 'package:firebase_auth/firebase_auth.dart';

abstract class RegisterModel {}

class FirebaseRegisterModel implements RegisterModel {
  final UserCredential _credential;

  FirebaseRegisterModel(this._credential);

  UserCredential get credential => _credential;
}

///O motivo de criar esse modelo é para que o repositório possa retornar um modelo específico
class ApiRestResgisterModel implements RegisterModel {
  final String token;

  ApiRestResgisterModel(this.token);

  @override
  String toString() => 'ApiRestResgisterModel(token: $token)';
}
