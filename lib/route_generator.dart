import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'error_route.dart';
import 'main.dart';

class RouteGenerator
{
  static Route<dynamic> generateRoute(RouteSettings settings){

    final args = settings.arguments;

    switch(settings.name){

      case '/':
        return MaterialPageRoute(builder: (_) => const Login());
    }

    return MaterialPageRoute(builder: (_) => const ErrorRoute());
  }

}