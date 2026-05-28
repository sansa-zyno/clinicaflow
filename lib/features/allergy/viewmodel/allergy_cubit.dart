import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:clinica_flow/features/allergy/model/allergies.dart';
import 'package:clinica_flow/core/utils/helper_models/error_model.dart';
import 'package:clinica_flow/features/allergy/service/allergy_service.dart';
import 'package:clinica_flow/core/utils/enums/bloc_enums.dart';

part '../state/allergy_state.dart';

class AllergyCubit extends Cubit<AllergyState> {
  AllergyCubit() : super(AllergyState(state: AllergyStates.initial));

  AllergyService service = AllergyService();

  Future<void> search(String query) async {
    emit(state.copyWith(state: AllergyStates.searchingForAllergies));
    try {
      final allergies = await service.searchAllergies(query);
      emit(state.copyWith(
          state: AllergyStates.searchingForAllergiesSuccess,
          allergies: allergies));
    } catch (e) {
      emit(state.copyWith(state: AllergyStates.searchingForAllergiesFailed));
    }
  }
}
