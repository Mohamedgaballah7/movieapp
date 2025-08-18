import 'package:flutter/material.dart';
import 'package:movieapproute/utils/app_routes.dart';

import 'home/homescreen.dart';

void main(){

  runApp( MyApp());
}

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {


    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.homeRouteName,
      routes: {
        AppRoutes.homeRouteName:(context)=>Homescreen(),
      },
    );
  }

}