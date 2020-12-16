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

  @computed
  List<Category> get allCategories => List.from(categoriesList)
    ..insert(0, Category(id: "*", description: "Todas"));

  @observable
  String error;

  @action
  void setError(String value) => error = value;

  @action
  void setCategories(List<Category> categories){
    categoriesList.clear();
    categoriesList.addAll(categories);
  }

  Future<void> _loadCategories() async{
    try{
      final categories = await CategoryRepository().getList();
      setCategories(categories);
    }catch (e){
      setError(e);
    }
  }

}