// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:to_do_list/logic/data.dart';

class LogicToDoList with ChangeNotifier {
  final List<ToDoList> _data = [];
  final List<ToDoList> _complete = [];

  void add(ToDoList toDoListData) {
    _data.add(toDoListData);
    notifyListeners();
  }

  void deleteTask(ToDoList toDoListData) {
    _data.remove(toDoListData);
    notifyListeners();
  }

  void changeState(ToDoList toDoListData) {
    final index = _data.indexOf(toDoListData);

    if (index != -1) {
      _data[index].state = !_data[index].state;
      notifyListeners();
    }
    if (_data[index].state) {
      _complete.add(_data[index]);
      _data.remove(_data[index]);
      notifyListeners();
    }
  }

  void changeStateUncomplete(ToDoList toDoListData) {
    final indexComplete = _complete.indexOf(toDoListData);
    if (indexComplete != -1) {
      _complete[indexComplete].state = !_complete[indexComplete].state;
      notifyListeners();
    }
    if (!_complete[indexComplete].state) {
      _data.add(_complete[indexComplete]);
      _complete.remove(_complete[indexComplete]);
      notifyListeners();
    }
  }
    void deleteCompleteTask(ToDoList toDoListData) {
    _complete.remove(toDoListData);
    notifyListeners();
  }
  void clearAllTasks() {
    _data.clear();
    notifyListeners();
  }

  int countTasks() => _data.length;
  int countTaskComplete() => _complete.length;
  List<ToDoList> get listTasks => _data;
  List<ToDoList> get listCompleteTasks => _complete;
}
