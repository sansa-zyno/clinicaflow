// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vitals_cubit.dart';

class VitalsState {
  final VitalsStates state;
  final String? message;
  final AppError? error;
  final Vital? savedVital;

  VitalsState({
    required this.state,
    this.message,
    this.error,
    this.savedVital,
  });

  VitalsState copyWith({
    VitalsStates? state,
    String? message,
    AppError? error,
    Vital? savedVital,
  }) {
    return VitalsState(
      state: state ?? this.state,
      message: message ?? this.message,
      error: error ?? this.error,
      savedVital: savedVital,
    );
  }

  @override
  String toString() {
    return 'VitalsState(state: $state, message: $message, vital: $savedVital, error: $error)';
  }
}
