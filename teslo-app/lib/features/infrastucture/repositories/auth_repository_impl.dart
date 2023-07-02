import 'package:teslo_shop/features/domain/domain.dart';
import 'package:teslo_shop/features/infrastucture/datasources/auth_datasource_impl.dart';

class AuthRepositoryImplementation extends AuthRepository  {
  final AuthDataSource dataSource;

  AuthRepositoryImplementation({
    AuthDataSource? dataSource
  }) : dataSource = dataSource ?? AuthDataSourceImplementation();

  @override
  Future<User> checkAuthStatus(String token) {
    return dataSource.checkAuthStatus(token);
  }

  @override
  Future<User> login(String email, String password) {
    return dataSource.login(email, password);
  }

  @override
  Future<User> register(String email, String password, String fullName) {
    return dataSource.register(email, password, fullName);
  }
}