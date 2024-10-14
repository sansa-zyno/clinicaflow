import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:healtether_clinic_app/data_layer/models/payment_model.dart/payment_json_model.dart';
import 'package:healtether_clinic_app/data_layer/models/payment_model.dart/paymnets_model.dart';
import 'package:meta/meta.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  ReceiptBloc() : super(ReceiptInitial()) {
    
    on<InitialLoadEvent>(initialLoadEvent);
    on<InitializePaymentEvent>(initializePaymentEvent);
  }

  FutureOr<void> initialLoadEvent(InitialLoadEvent event, Emitter<ReceiptState> emit) {


   final List<Payment> paymentList= event.items.map((e) => Payment(treatmentName: e.treatmentController.text, quantity:double.parse(e.quantityController.text), Amount: double.parse(e.amountController.text), discount: double.parse(e.rateController.text))).toList();
     
  emit(ReceiptLoadedState(payments: paymentList));



  }

  FutureOr<void> initializePaymentEvent(InitializePaymentEvent event, Emitter<ReceiptState> emit) {



    emit(PaymentSuccessfullState());
  }
}
