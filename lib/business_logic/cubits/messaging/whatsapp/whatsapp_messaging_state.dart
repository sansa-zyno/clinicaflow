part of 'whatsapp_messaging_cubit.dart';

class WhatsappMessagingState {
  final WhatsappMessagingStates state;

  WhatsappMessagingState({required this.state});

  WhatsappMessagingState copyWith({WhatsappMessagingStates? state}) {
    return WhatsappMessagingState(state: state ?? this.state);
  }
}
