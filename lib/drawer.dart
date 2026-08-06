import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/logic/change-language.dart';
import 'package:to_do_list/trash.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Container(
            height: 180,
            alignment: Alignment.bottomLeft,
            decoration: BoxDecoration(color: Color(0xffF08080)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                tr('title-options'),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TrashPage()),
              );
            },
            leading: Icon(Icons.delete_outlined),
            trailing: Icon(Icons.arrow_forward),
            title: Text(tr('btn-trash')),
          ),
          ListTile(
            onTap: () {
              toggleChnageLanguage(context);
              Navigator.pop(context);
            },
            leading: Icon(Icons.language),
            title: Text(tr('btn-language')),
          ),
        ],
      ),
    );
  }
}
