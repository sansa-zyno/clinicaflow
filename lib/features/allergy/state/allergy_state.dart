// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../viewmodel/allergy_cubit.dart';

class AllergyState {
  final AllergyStates state;
  final String? message;
  final Allergy? allergy;
  final List<Allergy>? allergies;
  final AppError? error;
  AllergyState({
    required this.state,
    this.message,
    this.allergy,
    this.allergies,
    this.error,
  });

  AllergyState copyWith({
    AllergyStates? state,
    String? message,
    Allergy? allergy,
    List<Allergy>? allergies,
    AppError? error,
  }) {
    return AllergyState(
      state: state ?? this.state,
      message: message ?? this.message,
      allergy: allergy ?? this.allergy,
      allergies: allergies ?? this.allergies,
      error: error ?? this.error,
    );
  }
}
