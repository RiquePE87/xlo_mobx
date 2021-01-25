import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:xlo_mobx/screens/create/components/images_source_dialog.dart';
import 'package:xlo_mobx/stores/create_store.dart';

import 'image_dialog.dart';

class ImagesField extends StatelessWidget {
  final CreateStore createStore;

  ImagesField(this.createStore);

  @override
  Widget build(BuildContext context) {
    void onImageSelected(File image) {
      createStore.images.add(image);
      Navigator.of(context).pop();
    }

    return Column(
      children: [
        Container(
          color: Colors.grey[200],
          height: 120,
          child: Observer(
            builder: (_) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: createStore.images.length < 5
                    ? createStore.images.length + 1
                    : 5,
                itemBuilder: (_, index) {
                  if (index == createStore.images.length) {
                    return GestureDetector(
                      onTap: () {
                        if (Platform.isAndroid) {
                          showModalBottomSheet(
                              context: context,
                              builder: (_) => ImagesSourceDialog(onImageSelected));
                        } else {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (_) => ImagesSourceDialog(onImageSelected));
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
                        child: CircleAvatar(
                          radius: 44,
                          backgroundColor: Colors.grey[300],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.camera_alt,
                                size: 40,
                                color: Colors.white,
                              ),
                              Text(
                                "+",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) =>
                                ImageDialog(createStore.images[index], () {
                                  createStore.images.removeAt(index);
                                }));
                      },
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(8, 16, index == 4 ? 8 : 0, 16),
                        child: CircleAvatar(
                          radius: 44,
                          backgroundImage: FileImage(createStore.images[index]),
                        ),
                      ),
                    );
                  }
                },
              );
            },
          ),
        ),
        Observer(
          builder: (_){
            if (createStore.imagesError != null)
               return Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.fromLTRB(16, 8, 0, 0),
                decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.red))),
                child: Text(createStore.imagesError, style: TextStyle(fontSize: 12, color: Colors.red),),
              );
                else return Container();
          },
        )
      ],
    );
  }
}
