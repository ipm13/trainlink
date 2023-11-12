import 'package:flutter/material.dart';

import 'calendar.dart';
import 'error_route.dart';
import 'home.dart';
import 'create_team.dart';
import 'main.dart';

class RouteGenerator
{
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/home':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/createTeam':
        return MaterialPageRoute(builder: (_) => const CreateTeam());
      case '/calendar':
        return MaterialPageRoute(builder: (_) => const Calendar());
    }

    return MaterialPageRoute(builder: (_) => const ErrorRoute());
  }

}