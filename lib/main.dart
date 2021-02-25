import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/add/add_page.dart';
import 'package:todo_app/main_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOアプリ',
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODOアプリ',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel()..getTodoListRealtime(),
        child:Scaffold(
          appBar: AppBar(
            title: Text('TODOアプリ'),
            actions: [
              Consumer<MainModel>(builder: (context, model,child) {
                  final isActive = model.checkShoudActiveCompleteButton();
                  return FlatButton(
                      onPressed: isActive
                            ? () async{
                              await model.deleteCheckedLists();
                               }
                            : null,
                      child: Text(
                        '完了',
                        style: TextStyle(
                          color: isActive
                              ? Colors.white
                              : Colors.white.withOpacity(0.5),
                        )
                      ));
                }
              )
            ],
          ),
          body: Consumer<MainModel>(builder: (context, model,child) {
            final todoList = model.todoList;
            return ListView(
              children: todoList.map(
                    (todo) => CheckboxListTile(
                      title: Text(todo.title),
                      value: todo.isSelected,
                      onChanged: (bool value) {
                        todo.isSelected = !todo.isSelected;
                        model.reload();
                      },
                    ),
              ).toList(),
            );

          }),          
          floatingActionButton:
              Consumer<MainModel>(builder: (context, model,child)  {
              return FloatingActionButton(
                onPressed: () async{
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddPage(model),
                      fullscreenDialog: true,
                    ),
                  );
                },
                tooltip: 'Increment',
                child: Icon(Icons.add),
              );
            }
          ),
        ),
      ),
    );
  }
}


