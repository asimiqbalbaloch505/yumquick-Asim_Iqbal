import 'package:flutter_bloc/flutter_bloc.dart';

// Events
abstract class AuthEvent {}

class LoginSubmitted extends AuthEvent {
  final String email;
  final String password;
  LoginSubmitted(this.email, this.password);
}

class SignUpSubmitted extends AuthEvent {
  final String fullName;
  final String email;
  final String password;
  SignUpSubmitted(this.fullName, this.email, this.password);
}

class ResetPasswordRequested extends AuthEvent {
  final String email;
  ResetPasswordRequested(this.email);
}

// States
abstract class AuthState {}

class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthFailure extends AuthState {
  final String message;
  AuthFailure(this.message);
}

// BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(milliseconds: 800)); // Mock API delay
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Please enter valid credentials.'));
      }
    });

    on<SignUpSubmitted>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      if (event.email.isNotEmpty && event.password.isNotEmpty) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailure('Please fill in all fields.'));
      }
    });

    on<ResetPasswordRequested>((event, emit) async {
      emit(AuthLoading());
      await Future.delayed(const Duration(milliseconds: 800));
      emit(AuthSuccess());
    });
  }
}