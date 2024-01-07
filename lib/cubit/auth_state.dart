part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {
  AuthInitial();
}

class AuthLoading extends AuthState {
  AuthLoading();
}

class AuthLoaded extends AuthState {
  late List<UserModel> AuthsLists;
  AuthLoaded(this.AuthsLists);
}

class AuthError extends AuthState {
  AuthError();
}

class ChangeisLoading extends AuthState {
  bool isLoading;
  ChangeisLoading(this.isLoading);
}