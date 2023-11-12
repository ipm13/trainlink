import 'package:flutter/material.dart';

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
    }

    return MaterialPageRoute(builder: (_) => const ErrorRoute());
  }

}