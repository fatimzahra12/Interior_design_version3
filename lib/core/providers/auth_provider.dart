import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../services/storage_service.dart';

// Provider pour ApiService : Donne accès aux appels API (backend)
final apiServiceProvider = Provider((ref) => ApiService());

// Provider pour StorageService : Gère le stockage local
final storageServiceProvider = Provider((ref) => StorageService());

// Provider pour l'état d'authentification
final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(
    ref.read(apiServiceProvider),
    ref.read(storageServiceProvider),
  );
});

// État d'authentification
class AuthState {
  final bool isAuthenticated;
  final String? token;
  final String? userEmail;
  final bool isLoading;
  final String? error;

  AuthState({
    this.isAuthenticated = false,
    this.token,
    this.userEmail,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    String? token,
    String? userEmail,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      token: token ?? this.token,
      userEmail: userEmail ?? this.userEmail,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

// Notifier pour gérer l'authentification
class AuthNotifier extends StateNotifier<AuthState> {
  final ApiService _apiService;
  final StorageService _storageService;

  AuthNotifier(this._apiService, this._storageService) : super(AuthState()) {
    _checkAuthStatus();
  }

  // Vérifier si l'utilisateur est connecté au démarrage
  Future<void> _checkAuthStatus() async {
    final token = await _storageService.getToken();
    final email = await _storageService.getUserEmail();

    if (token != null) {
      state = state.copyWith(
        isAuthenticated: true,
        token: token,
        userEmail: email,
      );
    }
  }

  // Inscription
  Future<bool> register({
    required String email,
    required String username,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.register(
        email: email,
        username: username,
        password: password,
      );

      final token = response['access_token'];
      await _storageService.saveToken(token);
      await _storageService.saveUserEmail(email);

      state = state.copyWith(
        isAuthenticated: true,
        token: token,
        userEmail: email,
        isLoading: false,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  // Connexion
  Future<bool> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await _apiService.login(
        email: email,
        password: password,
      );

      final token = response['access_token'];
      await _storageService.saveToken(token);
      await _storageService.saveUserEmail(email);

      state = state.copyWith(
        isAuthenticated: true,
        token: token,
        userEmail: email,
        isLoading: false,
      );

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  // Déconnexion
  Future<void> logout() async {
    await _storageService.clearAll();
    state = AuthState();
  }
}