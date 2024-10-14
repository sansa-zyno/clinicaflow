import 'package:flutter_bloc/flutter_bloc.dart';

class IsEditCubit extends Cubit<Map<bool, String>> {
  IsEditCubit() : super({false: ""});
  void setValue(bool val, String id) {
    emit({true: id});
  }
}
