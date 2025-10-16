import 'package:counter_task/add_counter.dart';
import 'package:counter_task/config/routes/routes_name.dart';
import 'package:counter_task/counter_app.dart';
import 'package:flutter/material.dart';

class RoutesHandler {
   Route generateroute(RouteSettings setting){
    switch(setting.name){
     case RoutesName.home:
     return MaterialPageRoute(builder: (context)=> CounterApp());
     case RoutesName.add:
     return MaterialPageRoute(builder: (context)=>AddCounter());
     default:
     return MaterialPageRoute(
      builder: (context)=> const Scaffold(
        body: Center(
          child: Text("No Data"),
        ),
      )
      );
    }
  } 
}