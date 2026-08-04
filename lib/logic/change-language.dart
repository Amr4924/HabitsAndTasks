import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

void toggleChnageLanguage(BuildContext context) {
  if (context.locale == const Locale('en', 'US')) {
    context.setLocale(const Locale('ar', 'EG'));
  } else {
    context.setLocale(const Locale('en', 'US'));
  }
}
