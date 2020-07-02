import 'package:mobx/mobx.dart';

part 'theme.g.dart';

class ThemeStore = _ThemeStore with _$ThemeStore;

abstract class _ThemeStore with Store {
  @observable
  bool darkMode = false;

  @action
  void change(bool mode) {
    this.darkMode = mode;
  }
}
