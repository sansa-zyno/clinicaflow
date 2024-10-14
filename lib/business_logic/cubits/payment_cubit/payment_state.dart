// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_cubit.dart';

class PaymentState {
  final PaymentStates state;
  final List<GetPayment>? payments;

  PaymentState({
    required this.state,
    this.payments,
  });

  

  PaymentState copyWith({
    PaymentStates? state,
    List<GetPayment>? payments,
  }) {
    return PaymentState(
      state: state ?? this.state,
      payments: payments ?? this.payments,
    );
  }
}
