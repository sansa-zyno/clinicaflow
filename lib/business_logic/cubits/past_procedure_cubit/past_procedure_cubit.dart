import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/models/past_procedure/past_procedure.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';
part 'past_procedure_state.dart';


class PastProcedureCubit extends Cubit<PastProcedureState> {
  PastProcedureCubit() : super(PastProcedureState(state: PastProcedureStates.initial));

}