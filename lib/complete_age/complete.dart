import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/drawer.dart';
import 'package:to_do_list/logic/To%20do%20list.dart';

class CompletePage extends StatefulWidget {
  const CompletePage({super.key});

  @override
  State<CompletePage> createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {
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
    final String period = dateTime.hour >= 12 ? tr('hour-pm') : tr('hour-am');
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
          tr('done-tasks'),
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
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
                    '${context.watch<LogicToDoList>().countTaskComplete()}',
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
        ],
      ),

      body: Consumer<LogicToDoList>(
        builder: (context, value, child) {
          if (value.listCompleteTasks.isEmpty) {
            return Center(
              child: Text(
                tr('no-completed'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 206, 201, 201),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: value.countTaskComplete(),
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card(
                  color: const Color.fromARGB(255, 215, 206, 204),
                  child: ListTile(
                    leading: value.listCompleteTasks[i].state
                        ? Icon(Icons.done_all, color: Colors.green)
                        : Icon(Icons.task),
                    title: Text(value.listCompleteTasks[i].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          value.listCompleteTasks[i].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _formatTaskTime(
                            value.listCompleteTasks[i].selectTime,
                          ),
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
                          activeColor: Colors.green,
                          value: value.listCompleteTasks[i].state,
                          onChanged: (valueChanged) {
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
                              desc: tr('convert-warning'),
                              btnOkOnPress: () {
                                value.changeStateUncomplete(
                                  value.listCompleteTasks[i],
                                );
                              },
                              btnCancelOnPress: () {},
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
                                value.deleteCompleteTask(
                                  value.listCompleteTasks[i],
                                );
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
    );
  }
}
