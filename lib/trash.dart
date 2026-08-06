import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/logic/To%20do%20list.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => _TrashPageState();
}

class _TrashPageState extends State<TrashPage> {
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
      appBar: AppBar(
        backgroundColor: Color(0xffF08080),
        title: Text(
          tr('btn-trash'),
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
                    '${context.watch<LogicToDoList>().countTrash()}',
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
              if (context.read<LogicToDoList>().listTrash.isEmpty) {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.leftSlide,
                  dialogType: DialogType.error,
                  customHeader: CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.red,
                    child: Icon(Icons.close, color: Colors.white, size: 44),
                  ),
                  title: tr('txt-There-are-no-tasks-in-Trash-delete.'),
                  btnOkOnPress: () {},
                  btnOkText: tr('btn-done'),
                  btnOkColor: Colors.red,
                ).show();
              } else {
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
                    context.read<LogicToDoList>().clearTrash();
                  },
                  btnCancelOnPress: () {},
                ).show();
              }
            },
            tooltip: tr("txt-delete-all"),
            icon: Icon(Icons.delete_sweep_outlined),
          ),
        ],
      ),

      body: Consumer<LogicToDoList>(
        builder: (context, value, child) {
          if (value.listTrash.isEmpty) {
            return Center(
              child: Text(
                tr('txt-no-trash'),
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 206, 201, 201),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: value.countTrash(),
            itemBuilder: (context, i) {
              // Each card represents one task and exposes complete/delete actions.
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
                    title: Text(value.listTrash[i].name),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          value.listTrash[i].description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _formatTaskTime(value.listTrash[i].selectTime),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.black54,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${tr('txt-state')}: ${value.listTrash[i].state ? tr("txt-comlete") : tr("txt-incomlete")}",
                        ),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
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
                              desc: tr('btn-delete-forever-dialog'),
                              btnOkOnPress: () {
                                value.finalDeletion(value.listTrash[i]);
                              },
                              btnCancelOnPress: () {},
                            ).show();
                          },
                          tooltip: tr('btn-delete-forever'),
                          icon: Icon(
                            Icons.delete_forever_outlined,
                            color: Colors.red,
                          ),
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
                              desc: tr('btn-restore-dialog'),
                              btnOkOnPress: () {
                                value.revertDeletion(value.listTrash[i]);
                              },
                              btnCancelOnPress: () {},
                            ).show();
                          },
                          tooltip: tr('btn-restore'),
                          icon: Icon(
                            Icons.restore_from_trash_outlined,
                            color: Colors.green,
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
