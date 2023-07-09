import 'package:dio/dio.dart';
import 'package:teslo_shop/config/constants/environment.dart';
import 'package:teslo_shop/features/domain/datasources/auth_datasource.dart';
import 'package:teslo_shop/features/domain/entities/user.dart';
import 'package:teslo_shop/features/infrastucture/infrastucture.dart';

class AuthDataSourceImplementation extends AuthDataSource {
  final dio = Dio(
    BaseOptions(
      baseUrl: Environment.apiUrl,
    )
  );

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post('/auth/login', data: {
        'email': email,
        'password': password
      });

      final user = UserMapper.userJsonToEntity(response.data);

      return user;
    } on DioException catch (e) {
      if(e.response?.statusCode == 401) throw CustomError(e.response?.data['message'] ?? 'Invalid credentials');
      if(e.type == DioExceptionType.connectionTimeout) throw CustomError(e.response?.data['message'] ?? 'Check your internet connection');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> register(String email, String password, String fullName) async {
    try {
      final response = await dio.post('/auth/register', data: {
        'email': email,
        'password': password,
        'fullName': fullName,
      });

      final user = UserMapper.userJsonToEntity(response.data);

      return user;
    } on DioException catch (e) {
      if(e.response?.statusCode == 400) throw CustomError('Email already exists');
      if(e.type == DioExceptionType.connectionTimeout) throw CustomError('Check your internet connection');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
  
  @override
  Future<User> checkAuthStatus(String token) async {
    try {
      final response = await dio.get('/auth/check-status', options: Options(headers: {
        'Authorization': 'Bearer $token',
      }));

      final user  = UserMapper.userJsonToEntity(response.data);

      return user;
    } on DioException catch (e) {
      if(e.response?.statusCode == 401) throw CustomError('Inalid token');
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
