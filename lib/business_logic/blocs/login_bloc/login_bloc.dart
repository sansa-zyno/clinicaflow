import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:healtether_clinic_app/data_layer/services/auth/auth_services.dart';
import 'package:healtether_clinic_app/data_layer/services/shared_preferences_service.dart';
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
    String result = await AuthService.loginUser(
        event.number, event.password, event.context);
    if (result == "Login Success") {
      emit(LoginSuccessfulState());
    } else {
      emit(LoginFailState(error: result));
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
