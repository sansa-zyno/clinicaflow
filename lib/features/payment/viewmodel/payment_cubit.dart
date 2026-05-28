import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/features/payment/model/invoice.dart';
import 'package:clinica_flow/features/payment/service/payment_service.dart';
import 'package:clinica_flow/features/payment/model/payment_response_model.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';
import 'package:clinica_flow/core/utils/helper_functions/log.dart';

part '../state/payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentState(state: PaymentStates.initial));

  PaymentService service = PaymentService();

  Future fetchPayments() async {
    try {
      emit(state.copyWith(state: PaymentStates.fetchingPayments));

      final payments = await service.fetchPayment();

      emit(state.copyWith(
          state: PaymentStates.paymentsFetched, payments: payments));
    } catch (e) {
      emit(state.copyWith(state: PaymentStates.fetchingPaymentsFailed));
      log('Error fetching payments: $e');
    }
  }

  Future setCashPayment({
    required String invoiceId,
    required int amount,
    required String paymentMode,
  }) async {
    try {
      emit(state.copyWith(state: PaymentStates.addingPayment));
      final invoice = await service.setCashPayment(
          invoiceId: invoiceId, amount: amount, paymentMode: paymentMode);
      emit(state.copyWith(state: PaymentStates.paymentAdded, invoice: invoice));
    } catch (e) {
      emit(state.copyWith(
          state: PaymentStates.addingPaymentFailed, error: e.toString()));
      log('Error adding payment: $e');
    }
  }
}
