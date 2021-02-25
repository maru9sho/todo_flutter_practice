import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class AddModel extends ChangeNotifier {
  String todoText = '';

  Future add() async{
    final collection = FirebaseFirestore.instance.collection('todoList');
    await collection.add({
      'title': todoText, // John Doe
      'createdAt': Timestamp.now(), // Stokes and Sons
    });

  }

}