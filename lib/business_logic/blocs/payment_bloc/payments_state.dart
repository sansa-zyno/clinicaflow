part of 'payments_bloc.dart';

@immutable
sealed class PaymentsState {}

final class PaymentsInitial extends PaymentsState {

  

}
final class PaymentManageState extends PaymentsState{

  final List<PaymentModel> items;

  PaymentManageState({required this.items});
}

final class PaymentScreenActionState extends PaymentsState{}


final class PaymnetScreenVerifiedState extends PaymentScreenActionState{}


