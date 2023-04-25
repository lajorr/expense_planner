// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'widgets/my_home_page.dart';

void main() {
  // // to lock in portrait mode
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //   ],
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'Shalimar',
          textTheme: TextTheme(
            titleLarge: TextStyle(
              fontFamily: 'Shalimar',
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 5,
            ),
            titleSmall: TextStyle(
              fontFamily: 'Shalimar',
              fontSize: 20,
              // fontWeight: FontWeight.bold,
              // letterSpacing: 1,
            ),
          ),
          appBarTheme: AppBarTheme(
            titleTextStyle: TextStyle(
                fontFamily: 'Shalimar',
                fontSize: 36,
                fontWeight: FontWeight.bold,
                letterSpacing: 2),
          ),
          primarySwatch: Colors.purple,
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
          )

          // for some reason this affects the appbar??? it changes back to blue even tho my primary is purple
          // colorScheme: ColorScheme.fromSwatch(
          //   accentColor: Colors.amber,
          // ),
          ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}
