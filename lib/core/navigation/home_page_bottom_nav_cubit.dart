import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageBottomNavCubit extends Cubit<int> {
  HomePageBottomNavCubit() : super(0);

  void onPageChanged(int page) {
    emit(page);
  }
}
