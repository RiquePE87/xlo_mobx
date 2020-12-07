import 'package:mobx/mobx.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/repositories/category_repository.dart';

part "category_store.g.dart";

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store{

  ObservableList<Category> categoriesList = ObservableList();

  _CategoryStore(){
    _loadCategories();
  }

  Future<void> _loadCategories() async{

    final categories = await CategoryRepository().getList();

  }

}