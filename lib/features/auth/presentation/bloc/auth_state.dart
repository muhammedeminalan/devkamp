part of 'auth_bloc.dart';

enum AuthStatus {
  unknown,
  unauthenticated,
  authenticated,
}

final class AuthState extends Equatable {
  const AuthState({
    required this.status,
    this.user,
    this.isLoading = false,
    this.errorMessage,
  });

  const AuthState.initial()
      : status = AuthStatus.unknown,
        user = null,
        isLoading = false,
        errorMessage = null;

  final AuthStatus status;
  final AppUser? user;
  final bool isLoading;
  final String? errorMessage;

  AuthState copyWith({
    AuthStatus? status,
    AppUser? user,
    bool clearUser = false,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => <Object?>[status, user, isLoading, errorMessage];
}
