part of 'payments_bloc.dart';

@immutable
sealed class PaymentsEvent {}
final class ItemAddedEvent  extends PaymentsEvent{
   final List<PaymentModel> Items;

  ItemAddedEvent({required this.Items});

}
final class DeleteItemEvent extends PaymentsEvent{

 final int index;
  DeleteItemEvent({required this.index});
}
final class InitialPaymentLoadEvent extends PaymentsEvent{
  final List<PaymentModel> Items;

  InitialPaymentLoadEvent({required this.Items});
}

final class VerifyPaymentsItemsEvent extends PaymentsEvent{
   final List<PaymentModel> Items;

  VerifyPaymentsItemsEvent({required this.Items});

}


