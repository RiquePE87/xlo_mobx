import 'package:mobx/mobx.dart';

part 'pages_store.g.dart';

class PagesStore = _PagesStore with _$PagesStore;

abstract class _PagesStore with Store{

  @observable
  int page = 0;

  @action
  void setPage(int value)=> page = value;
}


