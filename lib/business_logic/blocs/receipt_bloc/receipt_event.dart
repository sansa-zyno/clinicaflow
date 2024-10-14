part of 'receipt_bloc.dart';

@immutable
sealed class ReceiptEvent {}
final class InitialLoadEvent extends ReceiptEvent{

  final List<PaymentModel> items;

  InitialLoadEvent({required this.items});

}

final class InitializePaymentEvent extends ReceiptEvent{}