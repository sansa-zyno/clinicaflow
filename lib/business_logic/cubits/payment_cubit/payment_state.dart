// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_cubit.dart';

class PaymentState {
  final PaymentStates state;
  final List<GetPayment>? payments;
  final Invoice? invoice;
  final String? error;

  PaymentState({required this.state, this.payments, this.invoice, this.error});

  PaymentState copyWith({
    PaymentStates? state,
    List<GetPayment>? payments,
    Invoice? invoice,
    String? error,
  }) {
    return PaymentState(
      state: state ?? this.state,
      payments: payments ?? this.payments,
      invoice: invoice ?? this.invoice,
      error: error ?? this.error,
    );
  }
}
