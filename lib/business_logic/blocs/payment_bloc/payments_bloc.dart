import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:healtether_clinic_app/data_layer/models/payment_model.dart/paymnets_model.dart';
import 'package:meta/meta.dart';
part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  PaymentsBloc() : super(PaymentsInitial()) {
    on<ItemAddedEvent>(itemAddedEvent);
    on<DeleteItemEvent>(deleteItemEvent);
    on<InitialPaymentLoadEvent>(initialPaymentLoadEvent);
    on<VerifyPaymentsItemsEvent>(verifyPaymentsItemsEvent);
  }

  FutureOr<void> itemAddedEvent(ItemAddedEvent event, Emitter<PaymentsState> emit) {

    //List<PaymentModel> items=event.Items;

    event.Items.add(PaymentModel(treatmentController: TextEditingController(),
     amountController: TextEditingController(),
      quantityController: TextEditingController(),
       rateController: TextEditingController(),
       formKey: GlobalKey<FormState>()
       
       ));

    emit(PaymentManageState(items: event.Items));
  }

  FutureOr<void> deleteItemEvent(DeleteItemEvent event, Emitter<PaymentsState> emit) {

    
  final currentstate=state;

List<PaymentModel> items=[];

   
  if(currentstate is PaymentManageState){

    items=currentstate.items;


    items.removeAt(event.index);
  }
  
    

   

   emit(PaymentManageState(items:items));
  }

  FutureOr<void> initialPaymentLoadEvent(InitialPaymentLoadEvent event, Emitter<PaymentsState> emit) {


    emit(PaymentManageState(items: event.Items));
  }

  FutureOr<void> verifyPaymentsItemsEvent(VerifyPaymentsItemsEvent event, Emitter<PaymentsState> emit) {
  bool check=true;

  event.Items.forEach((element) { 

    if(element.formKey.currentState!.validate()){

        
    }
    else check=false;

  });
    

    if(check) emit(PaymnetScreenVerifiedState());
  }
}
