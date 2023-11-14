import 'package:flutter/material.dart';

import 'login.dart';
import 'error_route.dart';
import 'home.dart';
import 'team.dart';
import 'create_team.dart';
import 'calendar.dart';

class RouteGenerator
{
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){
      case '/':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/home':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/team':
        return MaterialPageRoute(builder: (_) => const Team());
      case '/createTeam':
        return MaterialPageRoute(builder: (_) => const CreateTeam());
      case '/calendar':
        return MaterialPageRoute(builder: (_) => const Calendar());
    }

    return MaterialPageRoute(builder: (_) => const ErrorRoute());
  }

}