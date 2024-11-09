import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/services/messaging/whatsapp_messaging_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
part 'whatsapp_messaging_state.dart';

class WhatsappMessagingCubit extends Cubit<WhatsappMessagingState> {
  WhatsappMessagingCubit() : super(WhatsappMessagingState(state: WhatsappMessagingStates.initial));

  WhatSappMessagingService service = WhatSappMessagingService();

  sendWhatsappMsg({required String phoneNo, required String message}) async {
    emit(state.copyWith(state: WhatsappMessagingStates.sendingMessage));
    try {
      bool res = await service.sendWhatsappMsg(phoneNo: phoneNo, message: message);
      emit(state.copyWith(state: WhatsappMessagingStates.sendingMessageDone));
    } catch (error) {
      log('Failed to send message: $error');
      emit(state.copyWith(state: WhatsappMessagingStates.sendingMessageFailed));
    }
  }
}
