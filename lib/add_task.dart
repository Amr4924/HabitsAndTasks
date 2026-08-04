import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/logic/To%20do%20list.dart';
import 'package:to_do_list/logic/data.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  Future<DateTime?> _selectDateTime(BuildContext context) async {
    // 1. اختيار التاريخ
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      // 2. اختيار الوقت بعد تحديد التاريخ
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (pickedTime != null) {
        // 3. دمج التاريخ والوقت في كائن DateTime واحد
        DateTime fullDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );

        return fullDateTime;
      }
    }

    return null;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(),
      backgroundColor: Color(0xffF08080),
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text(tr('enter-data')),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Field Title
                  TextField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: tr('label-title'),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Field Description
                  TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: tr('label-description'),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(tr('cancel')),
                ),
                ElevatedButton(
                  onPressed: () async {
                    String title = titleController.text;
                    String description = descriptionController.text;
                    if (title.trim().isEmpty || description.trim().isEmpty) {
                      return;
                    }

                    final DateTime? selectedDateTime = await _selectDateTime(
                      context,
                    );
                    if (selectedDateTime == null) {
                      return;
                    }

                    Navigator.pop(dialogContext);
                    context.read<LogicToDoList>().add(
                      ToDoList(
                        name: title,
                        description: description,
                        selectTime: selectedDateTime,
                      ),
                    );
                    AwesomeDialog(
                      context: context,
                      animType: AnimType.scale,
                      dialogType: DialogType.success,
                      customHeader: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.green,
                        child: Icon(Icons.done, color: Colors.white, size: 44),
                      ),
                      title: tr('Successful-mg'),
                      btnOkOnPress: () {},
                      btnOkText: tr('btn-done'),
                    ).show();
                  },
                  child: Text(tr('save')),
                ),
              ],
            );
          },
        );
      },
      child: Icon(Icons.add_task_outlined, color: Colors.white),
    );
  }
}
