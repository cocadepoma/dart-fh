import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/domain/domain.dart';
import 'package:teslo_shop/features/infrastucture/infrastucture.dart';
import 'package:teslo_shop/features/shared/infrastucture/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImplementation();
  final keyValueStorageServiceImpl = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageServiceImpl: keyValueStorageServiceImpl,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageServiceImpl keyValueStorageServiceImpl;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageServiceImpl,
  }): super(AuthState()) {
    checkAuthStatus();
  }
  
  Future<void> loginUser (String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch(e) {
      logout(e.message);
    } catch (e) {
      logout('Not controlled error');
    }
  }

  void registerUser (String email, String password, String fullName) async {
    try {
      final user = await authRepository.register(email, password, fullName);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Not controlled error');
    }
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageServiceImpl.getValue<String>('token');

    if(token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(User user) async {
    await keyValueStorageServiceImpl.setKeyValue('token', user.token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async {
    await keyValueStorageServiceImpl.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );
  }
}

enum AuthStatus {checking, authenticated, notAuthenticated}

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = ''
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
}