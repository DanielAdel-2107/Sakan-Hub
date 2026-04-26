import '../../models/profile_model.dart';

sealed class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final ProfileModel profile;
  AuthSuccess(this.profile);
}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}
