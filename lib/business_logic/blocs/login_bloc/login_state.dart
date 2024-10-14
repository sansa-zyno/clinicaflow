part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}
final class LoginProcessState extends LoginState{}

final class LoginActionState extends LoginState{}

final class LoginSuccessState extends LoginActionState{}

final class LoginSuccessfulState extends LoginActionState{}

final class LoginFailState extends LoginActionState{
    final String error;

  LoginFailState({required this.error});
}
