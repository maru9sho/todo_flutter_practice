

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/add/add_model.dart';

import '../main_model.dart';

class AddPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddModel>(
      create: (_) => AddModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('新規追加'),
        ),
        body: Consumer<AddModel>(builder: (context, model, child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(children: [
              TextField(
                decoration: InputDecoration(
                    labelText: "追加するtodo",
                    hintText: "ex)ゴミを出す"),
                onChanged: (text){
                  model.todoText = text;
                },
              ),
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                  child: Text('追加する'),
                  onPressed: () async{
                    // firestoreに値を追加する。
                    await model.add();
                    Navigator.pop(context);
                  }),

            ],
            ),
          );
        }),
      ),
    );
  }
}
