import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:clinica_flow/features/auth/service/auth_services.dart';
import 'package:clinica_flow/core/utils/shared_preferences_service.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LogingProcessEvent>(logingProcessEvent);
    on<LoginRestartEvent>(loginRestartEvent);
  }

  FutureOr<void> logingProcessEvent(
      LogingProcessEvent event, Emitter<LoginState> emit) async {
    emit(LoginProcessState());
    String? result =
        await AuthService.loginUser(event.email, event.password, event.context);
    if (result != null) {
      emit(LoginSuccessfulState());
    } else {
      emit(LoginFailState(error: 'Log in failed'));
    }
  }

  FutureOr<void> loginRestartEvent(
      LoginRestartEvent event, Emitter<LoginState> emit) async {
    // immediately log user out
    emit(LoginInitial());

    // clear token
    await SharedPrefService.deleteAccessToken();
    await SharedPrefService.deleteUser();
  }
}
