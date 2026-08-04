class ToDoList {
  String name;
  String description;
  bool state;
  DateTime selectTime;
  ToDoList({required this.name, required this.description, this.state = false,required this.selectTime});
}
