import 'package:flutter/material.dart';
import 'package:trainlink/schedule.dart';

import 'login.dart';
import 'choose_role.dart';
import 'register.dart';
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
      case '/role':
        return MaterialPageRoute(builder: (_) => const ChooseRole());
      case '/register':
        return MaterialPageRoute(builder: (_) => const Register());
      case '/home':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/team':
        return MaterialPageRoute(builder: (_) => const Team());
      case '/createTeam':
        return MaterialPageRoute(builder: (_) => const CreateTeam());
      case '/calendar':
        return MaterialPageRoute(builder: (_) => const Calendar());
      case '/schedule':
        return MaterialPageRoute(builder: (_) => const Schedule());
    }

    return MaterialPageRoute(builder: (_) => const ErrorRoute());
  }

}