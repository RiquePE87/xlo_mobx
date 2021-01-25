import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/category/category_screen.dart';
import 'package:xlo_mobx/stores/create_store.dart';
import 'package:flutter/material.dart';

class CategoryField extends StatelessWidget {
  final CreateStore createStore;

  CategoryField(this.createStore);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return Column(
        children: [
          ListTile(
            trailing: Icon(Icons.keyboard_arrow_down),
            subtitle: createStore.category == null
                ? null
                : Text(
                    createStore.category.description,
                    style: TextStyle(fontSize: 17, color: Colors.black),
                  ),
            title: createStore.category == null
                ? Text(
                    "Categoria *",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.grey,
                        fontSize: 18),
                  )
                : Text(
                    "Categoria *",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: Colors.grey,
                        fontSize: 14),
                  ),
            onTap: () async {
              final category = await showDialog(
                  context: context,
                  builder: (_) => CategoryScreen(
                        showAll: false,
                        selected: createStore.category,
                      ));

              if (category != null) {
                createStore.setCategory(category);
              }
            },
          ),
          if (createStore.categoryError != null)
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
              decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.red))),
              child: Text(
                createStore.categoryError,
                style: TextStyle(fontSize: 12, color: Colors.red),
              ),
            )
          else
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey)
                )
              ),
            )
        ],
      );
    });
  }
}
