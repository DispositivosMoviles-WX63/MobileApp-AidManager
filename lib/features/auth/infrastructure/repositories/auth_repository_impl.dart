import 'package:aidmanager_mobile/features/auth/domain/datasources/auth_datasource.dart';
import 'package:aidmanager_mobile/features/auth/domain/entities/user.dart';
import 'package:aidmanager_mobile/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({required this.datasource});

  @override
  Future<AuthResponse> signIn(String email, String password) {
    return datasource.signIn(email, password);
  }

  @override
  Future<void> signUp(User user) {
    return datasource.signUp(user);
  }
}