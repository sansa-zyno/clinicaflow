// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'past_history.dart';

class PastHistoryResponse {
  final bool success;
  final String? message;
  final PastHistory? pastHistory;
  final List<PastHistory>? pastHistories;
  PastHistoryResponse({
    required this.success,
    this.message,
    this.pastHistory,
    this.pastHistories,
  });

  @override
  String toString() {
    return 'PastHistoryResponse(success: $success, message: $message, pastHistory: $pastHistory, pastHistories: $pastHistories)';
  }
}
