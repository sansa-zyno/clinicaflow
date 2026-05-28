import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/features/chat/service/whatsapp_messaging_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
part '../state/whatsapp_messaging_state.dart';

class WhatsappMessagingCubit extends Cubit<WhatsappMessagingState> {
  WhatsappMessagingCubit()
      : super(WhatsappMessagingState(state: WhatsappMessagingStates.initial));

  WhatSappMessagingService service = WhatSappMessagingService();

  sendWhatsappMsg({required String phoneNo, required String message}) async {
    emit(state.copyWith(state: WhatsappMessagingStates.sendingMessage));
    try {
      await service.sendWhatsappMsg(phoneNo: phoneNo, message: message);
      emit(state.copyWith(state: WhatsappMessagingStates.sendingMessageDone));
    } catch (error) {
      log('Failed to send message: $error');
      emit(state.copyWith(state: WhatsappMessagingStates.sendingMessageFailed));
    }
  }
}
