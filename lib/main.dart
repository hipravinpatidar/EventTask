import 'package:eventdesign/controller/language_provider.dart';
import 'package:eventdesign/view/ProceedPage.dart';
import 'package:eventdesign/view/useless_code/frontpage.dart';
import 'package:eventdesign/view/home_page/event_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'controller/data_logic.dart';


void main() {
  runApp(MultiProvider(providers: [

    ChangeNotifierProvider(create: (context) => LanguageProvider(),)

  ],
  child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Provider Demo',
          theme: ThemeData(
            primarySwatch: Colors.green,
          ),
          home: EventHome()
      );
  }
}
