import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/invoice/invoice.dart';
import 'package:healtether_clinic_app/data_layer/services/payment_service/payment_service.dart';
import 'package:healtether_clinic_app/data_layer/models/payment_models/payment_response_model.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
import 'package:healtether_clinic_app/utils/helper_functions/log.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentState(state: PaymentStates.initial));

  PaymentService service = PaymentService();

  Future fetchPayments() async {
    try {
      emit(state.copyWith(state: PaymentStates.fetchingPayments));

      final payments = await service.fetchPayment();

      emit(state.copyWith(state: PaymentStates.paymentsFetched, payments: payments));
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
      final invoice = await service.setCashPayment(invoiceId: invoiceId, amount: amount, paymentMode: paymentMode);
      emit(state.copyWith(state: PaymentStates.paymentAdded, invoice: invoice));
    } catch (e) {
      emit(state.copyWith(state: PaymentStates.addingPaymentFailed, error: e.toString()));
      log('Error adding payment: $e');
    }
  }
}
