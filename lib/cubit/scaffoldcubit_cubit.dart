import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scaffoldcubit_state.dart';

class ScaffoldcubitCubit extends Cubit<ScaffoldcubitState> {
  ScaffoldcubitCubit() : super(routerMainMenuPage());

  void mainMenuPage() => emit(routerMainMenuPage());
  void commentsPage() => emit(routerCommentsPage());
  void throwTheDicePage() => emit(routerThrowTheDicePage());
  void ideasPage() => emit(routerIdeasPage());
  void myProfilePage() => emit(routerMyProfilePage());
}
