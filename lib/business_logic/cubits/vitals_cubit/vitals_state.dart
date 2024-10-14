// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'vitals_cubit.dart';

class VitalsState {
  final VitalsStates state;
  final String? message;
  final Vital? vital;
  final List<Vital>? vitals;
  final AppError? error;
  VitalsState({
    required this.state,
    this.message,
    this.vital,
    this.vitals,
    this.error,
  });

  VitalsState copyWith({
    VitalsStates? state,
    String? message,
    Vital? vital,
    List<Vital>? vitals,
    AppError? error,
  }) {
    return VitalsState(
      state: state ?? this.state,
      message: message ?? this.message,
      vital: vital ?? this.vital,
      vitals: vitals ?? this.vitals,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'VitalsState(state: $state, message: $message, vital: $vital, vitals: $vitals, error: $error)';
  }
}
