import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/components/custom_drawer/custom_drawer.dart';
import 'package:xlo_mobx/stores/cep_store.dart';
import 'package:xlo_mobx/stores/create_store.dart';

import 'components/category_field.dart';
import 'components/cep_field.dart';
import 'components/hide_phone_field.dart';
import 'components/images_field.dart';

class CreateScreen extends StatelessWidget {
  final CreateStore createStore = CreateStore();

  @override
  Widget build(BuildContext context) {
    final labelStyle = TextStyle(
        fontWeight: FontWeight.w800, color: Colors.grey, fontSize: 18);

    final contentPadding = const EdgeInsets.fromLTRB(16, 10, 12, 10);

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        title: Text("Criar Anúncio"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            clipBehavior: Clip.antiAlias,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            elevation: 8,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                ImagesField(createStore),
                Observer(builder: (_) {
                  return TextFormField(
                    onChanged: createStore.setTitle,
                    decoration: InputDecoration(
                      errorText: createStore.titleError,
                      labelText: "Título *",
                      labelStyle: labelStyle,
                      contentPadding: contentPadding,
                    ),
                  );
                }),
                Observer(builder: (_) {
                  return TextFormField(
                    onChanged: createStore.setDescription,
                    decoration: InputDecoration(
                        labelText: "Descrição *",
                        labelStyle: labelStyle,
                        contentPadding: contentPadding,
                        errorText: createStore.descriptionError),
                    maxLines: null,
                  );
                }),
                CategoryField(createStore),
                CepField(createStore),
                Observer(builder: (_){
                  return TextFormField(
                    onChanged: createStore.setPriceText,
                    decoration: InputDecoration(
                      errorText: createStore.priceError,
                      labelText: "Preço *",
                      labelStyle: labelStyle,
                      contentPadding: contentPadding,
                      prefixText: "R\$ ",
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      RealInputFormatter(centavos: true)
                    ],
                  );
                }),
                HidePhoneField(createStore),
                Observer(builder: (_){
                  return SizedBox(
                    height: 50,
                    child: GestureDetector(
                      onTap: createStore.invalidSendPressed,
                      child: RaisedButton(
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        onPressed: createStore.sendPressed,
                        child: Text(
                          "Enviar",
                          style: TextStyle(fontSize: 18),
                        ),
                        color: Colors.orange,
                        disabledColor: Colors.orange.withAlpha(120),
                        textColor: Colors.white,
                      ),
                    ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
