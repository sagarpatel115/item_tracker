import 'package:flutter/material.dart';
import 'package:item_tracker/view/home_view.dart';
import 'package:item_tracker/view_model/item_view_model.dart';
import 'package:provider/provider.dart';

import 'utils/screen_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size lcSize = MediaQuery.of(context).size;
    ScreenUtils.height = lcSize.height;
    ScreenUtils.width = lcSize.width;

    return MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (BuildContext context) => ItemViewModelProvider()),
    ],
    child:  MaterialApp(
      title: 'Flutter Item Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeView(),
    ),
    );
  }
}


