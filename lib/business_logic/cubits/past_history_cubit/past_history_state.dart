// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'past_history_cubit.dart';

class PastHistoryState {
  final PastHistoryStates state;
  final String? message;
  final PastHistory? pastHistory;
  final List<PastHistory>? pastHistories;
  final AppError? error;
  PastHistoryState({
    required this.state,
    this.pastHistory,
    this.pastHistories,
    this.message,
    this.error,
  });

  PastHistoryState copyWith({
    PastHistoryStates? state,
    PastHistory? pastHistory,
    List<PastHistory>? pastHistories,
    String? message,
    AppError? error,
  }) {
    return PastHistoryState(
      state: state ?? this.state,
      pastHistory: pastHistory ?? this.pastHistory,
      pastHistories: pastHistories ?? this.pastHistories,
      message: message ?? this.message,
      error: error ?? this.error,
    );
  }

  @override
  String toString() {
    return 'PastHistoryState(state: $state, message: $message, pastHistory: $pastHistory, pastHistories: $pastHistories, error: $error)';
  }
}
