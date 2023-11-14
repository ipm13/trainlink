import 'package:flutter/material.dart';
import 'package:trainlink/schedule.dart';

import 'calendar.dart';
import 'error_route.dart';
import 'main.dart';

class RouteGenerator
{
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/calendar':
        return MaterialPageRoute(builder: (_) => const Calendar());
      case '/schedule':
        return MaterialPageRoute(builder: (_) => const Schedule());
    }

    return MaterialPageRoute(builder: (_) => const ErrorRoute());
  }

}