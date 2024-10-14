part of 'receipt_bloc.dart';

@immutable
sealed class ReceiptState {}

final class ReceiptInitial extends ReceiptState {}

final class ReceiptLoadedState extends ReceiptState{

  final List<Payment> payments;

  ReceiptLoadedState({required this.payments});
}
final class PaymentDoneState extends ReceiptState{}
final class PaymentSuccessfullState extends PaymentDoneState{}