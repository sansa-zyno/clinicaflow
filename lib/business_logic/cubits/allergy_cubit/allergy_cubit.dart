import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:healtether_clinic_app/data_layer/models/allergies/allergies.dart';
import 'package:healtether_clinic_app/data_layer/models/helper_models/error_model.dart';
import 'package:healtether_clinic_app/data_layer/services/allergy_service/allergy_service.dart';
import 'package:healtether_clinic_app/utils/enums/bloc_enums.dart';

part 'allergy_state.dart';

class AllergyCubit extends Cubit<AllergyState> {
  AllergyCubit() : super(AllergyState(state: AllergyStates.initial));

  AllergyService service = AllergyService();

  Future<void> search(String query) async {
    emit(state.copyWith(state: AllergyStates.searchingForAllergies));
    try {
      final allergies = await service.searchAllergies(query);
      emit(state.copyWith(state: AllergyStates.searchingForAllergiesSuccess, allergies: allergies));
    } catch (e) {
      emit(state.copyWith(state: AllergyStates.searchingForAllergiesFailed));
    }
  }
}
