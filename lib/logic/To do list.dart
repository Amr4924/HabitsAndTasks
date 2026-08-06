// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:to_do_list/logic/data.dart';

// Manages the active and completed tasks and notifies the UI when data changes.
class LogicToDoList with ChangeNotifier {
  final List<ToDoList> _data = [];
  final List<ToDoList> _complete = [];
  final List<ToDoList> _trash = [];

  // Adds a new task to the active list.
  void add(ToDoList toDoListData) {
    _data.add(toDoListData);
    notifyListeners();
  }

  // Removes a task from the active list.
  void deleteTask(ToDoList toDoListData) {
    _trash.add(toDoListData);
    _data.remove(toDoListData);
    notifyListeners();
  }

  // Marks a task as complete and moves it to the completed list.
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

  // Returns a completed task back to the active list.
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

  // Removes a task from the completed list.
  void deleteCompleteTask(ToDoList toDoListData) {
    _trash.add(toDoListData);
    _complete.remove(toDoListData);
    notifyListeners();
  }

  // Clears all active tasks at once.
  void clearAllTasks() {
    _trash.addAll(_data);
    _data.clear();
    notifyListeners();
  }

  void revertDeletion(ToDoList toDoListData) {
    if (toDoListData.state) {
      _complete.add(toDoListData);
    } else {
      _data.add(toDoListData);
    }
    _trash.remove(toDoListData);
    notifyListeners();
  }

  void finalDeletion(ToDoList toDoListData) {
    _trash.remove(toDoListData);
    notifyListeners();
  }

  void clearTrash() {
    _trash.clear();
    notifyListeners();
  }

  // Exposes counters and read-only access for the UI.
  int countTasks() => _data.length;
  int countTaskComplete() => _complete.length;
  int countTrash() => _trash.length;
  List<ToDoList> get listTasks => _data;
  List<ToDoList> get listCompleteTasks => _complete;
  List<ToDoList> get listTrash => _trash;
}
