// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'past_procedure_cubit.dart';

class PastProcedureState {
  final PastProcedureStates state;
  final String? message;
  final PastProcedure? pastProcedure;
  final List<PastProcedure>? pastProcedures;
  final AppError? error;
  PastProcedureState({
    required this.state,
    this.message,
    this.pastProcedure,
    this.pastProcedures,
    this.error,
  });

  PastProcedureState copyWith({
    PastProcedureStates? state,
    String? message,
    PastProcedure? pastProcedure,
    List<PastProcedure>? pastProcedures,
    AppError? error,
  }) {
    return PastProcedureState(
      state: state ?? this.state,
      message: message ?? this.message,
      pastProcedure: pastProcedure ?? this.pastProcedure,
      pastProcedures: pastProcedures ?? this.pastProcedures,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'PastProcedureState(state: $state, message: $message, pastProcedure: $pastProcedure, pastProcedures: $pastProcedures, error: $error)';
  }
}
