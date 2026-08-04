import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/logic/change-language.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(height: 100),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              tr('title-options'),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Divider(height: 20),
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
