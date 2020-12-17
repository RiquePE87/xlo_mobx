import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:xlo_mobx/components/custom_drawer/error_box.dart';
import 'package:xlo_mobx/models/category.dart';
import 'package:xlo_mobx/stores/category_store.dart';

class CategoryScreen extends StatelessWidget {

  final Category selected;
  final bool showAll;
  final categoryStore = GetIt.I<CategoryStore>();

  CategoryScreen({this.selected, this.showAll = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categorias"),
      ),
      body: Card(
        elevation: 8,
        margin: const EdgeInsets.fromLTRB(32, 12, 32, 32),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
        ),
        child: Observer(builder: (_){
          if (categoryStore.error != null){
            return ErrorBox(message: categoryStore.error);
          }else if (categoryStore.categoriesList.isEmpty){
            return Center(
              child: CircularProgressIndicator()
            );
          }else{
            final categories = showAll ? categoryStore.allCategories : categoryStore.categoriesList;
            return ListView.separated(
                itemBuilder: (_, index){
                  final category = categories[index];
                  return InkWell(
                    onTap: ()=> Navigator.of(context).pop(category),
                    child: Container(
                      alignment: Alignment.center,
                      height: 50,
                      color: category.id == selected?.id ? Colors.purple.withAlpha(50) : null,
                      child: Text(category.description, style:
                      TextStyle(color: Colors.grey[700],
                          fontWeight: category.id == selected?.id ? FontWeight.bold : null)),
                    ),
                  );
                },
                separatorBuilder: (_,__){
                  return Divider(height: 0.1, color: Colors.grey);
                },
                itemCount: categories.length);
          }
        }),
      ),
    );
  }
}
