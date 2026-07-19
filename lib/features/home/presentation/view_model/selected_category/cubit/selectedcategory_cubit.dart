import 'package:bloc/bloc.dart';

class SelectedCategoryCubit extends Cubit<int?> {
  SelectedCategoryCubit() : super(null);
  void selectCategory(int id) {
    emit(id);
  }
}
