import 'package:flutter/material.dart';
import 'package:trainlink/register2.dart';
import 'package:trainlink/schedule.dart';

import 'login.dart';
import 'choose_role.dart';
import 'register.dart';
import 'error_route.dart';
import 'home.dart';
import 'team.dart';
import 'create_team.dart';
import 'calendar.dart';
import 'training.dart';
import 'create_train.dart';
import 'train.dart';

class RouteGenerator
{
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){
      case '/login':
        return MaterialPageRoute(builder: (_) => const Login());
      case '/role':
        return MaterialPageRoute(builder: (_) => const ChooseRole());
      case '/register':
        return MaterialPageRoute(builder: (_) => const Register());
      case '/register2':
        return MaterialPageRoute(builder: (_) => const Register2());
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
      case '/training':
        return MaterialPageRoute(builder: (_) => const Training());
      case '/createTrain':
        return MaterialPageRoute(builder: (_) => const CreateTrain());
      case '/train':
        return MaterialPageRoute(builder: (_) => const Train());
    }

    return MaterialPageRoute(builder: (_) => const ErrorRoute());
  }

}