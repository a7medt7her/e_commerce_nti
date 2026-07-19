import 'package:bloc/bloc.dart';

class SelectedItemCubit extends Cubit<int> {
  SelectedItemCubit() : super(1);
  void selectCategory(int id) {
    emit(id);
  }
}
