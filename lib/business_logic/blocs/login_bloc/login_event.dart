part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LogingProcessEvent extends LoginEvent{

  final String number;
  final String password;
  final BuildContext context;

  LogingProcessEvent({required this.number, required this.password,required this.context});


}
final class LoginRestartEvent extends LoginEvent{}
