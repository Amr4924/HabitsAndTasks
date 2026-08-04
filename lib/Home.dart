// ignore_for_file: file_names

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/add_task.dart';
import 'package:to_do_list/complete_age/complete.dart';
import 'package:to_do_list/drawer.dart';
import 'package:to_do_list/logic/To%20do%20list.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _formatTaskTime(DateTime dateTime) {
    final List<String> months = <String>[
      tr('month-Jan'),
      tr('month-Feb'),
      tr('month-Mar'),
      tr('month-Apr'),
      tr('month-May'),
      tr('month-Jun'),
      tr('month-Jul'),
      tr('month-Aug'),
      tr('month-Sep'),
      tr('month-Oct'),
      tr('month-Nov'),
      tr('month-Dec'),
    ];
    final int hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final String minute = dateTime.minute.toString().padLeft(2, '0');
    final String period = dateTime.hour >= 12 ? 'PM' : 'AM';
    return '${dateTime.day} ${months[dateTime.month - 1]} ${dateTime.year} - $hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 237, 230, 230),
      drawer: DrawerPage(),
      appBar: AppBar(
        backgroundColor: Color(0xffF08080),
        title: Text(
          tr('title-home'),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 10, bottom: 10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.18),
                borderRadius: BorderRadius.circular(999),
                border: Border.all(color: Colors.white.withValues(alpha: 0.35)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.task_alt_outlined,
                    color: Colors.white,
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${context.watch<LogicToDoList>().countTasks()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CompletePage()),
              );
            },
            icon: Icon(Icons.task_alt_outlined),
          ),
          IconButton(
            onPressed: () {
              AwesomeDialog(
                context: context,
                animType: AnimType.leftSlide,
                dialogType: DialogType.warning,
                customHeader: const CircleAvatar(
                  radius: 40,
                  backgroundColor: Color(0xffF08080),
                  child: Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.white,
                    size: 44,
                  ),
                ),
                title: tr('Warning'),
                desc: tr('Warning-des'),
                btnOkOnPress: () {
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
                  context.read<LogicToDoList>().clearAllTasks();
                },
                btnCancelOnPress: () {},
              ).show();
            },
            icon: Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),

      body: Consumer<LogicToDoList>(
        builder: (context, value, child) {
          if (value.listTasks.isEmpty) {
            return Center(
              child: Text(
                tr('no-task'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 206, 201, 201),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: value.countTasks(),
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  child: ListTile(
                    leading: const CircleAvatar(
                      radius: 16,
                      backgroundColor: Color(0x1AA1887F),
                      child: Icon(
                        Icons.radio_button_unchecked_rounded,
                        color: Color(0xFF6D4C41),
                        size: 18,
                      ),
                    ),
                    title: Text(value.listTasks[i].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          value.listTasks[i].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _formatTaskTime(value.listTasks[i].selectTime),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          side: BorderSide(color: Color(0xffF08080)),
                          value: value.listTasks[i].state,
                          onChanged: (valueChanged) {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.scale,
                              dialogType: DialogType.success,
                              customHeader: CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.green,
                                child: Icon(
                                  Icons.done,
                                  color: Colors.white,
                                  size: 44,
                                ),
                              ),
                              title: tr('Successful-mg'),
                              btnOkOnPress: () {
                                value.changeState(value.listTasks[i]);
                              },
                              btnOkText: tr('btn-done'),
                            ).show();
                          },
                        ),
                        IconButton(
                          onPressed: () {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.leftSlide,
                              dialogType: DialogType.warning,
                              customHeader: const CircleAvatar(
                                radius: 40,
                                backgroundColor: Color(0xffF08080),
                                child: Icon(
                                  Icons.warning_amber_rounded,
                                  color: Colors.white,
                                  size: 44,
                                ),
                              ),
                              title: tr('Warning'),
                              desc: tr('delete-warning'),
                              btnOkOnPress: () {
                                value.deleteTask(value.listTasks[i]);
                              },
                              btnCancelOnPress: () {},
                            ).show();
                          },
                          icon: Icon(
                            Icons.delete_forever,
                            color: Color.fromARGB(255, 255, 0, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: AddTask(),
    );
  }
}
