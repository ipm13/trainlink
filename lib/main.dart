import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trainlink/route_generator.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();

  SharedPreferences prefs = await SharedPreferences.getInstance();
  var email = prefs.getString('email');
  //prefs.clear();

  runApp(MyApp(initialRoute: email == null ? '/login' : '/home'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrainLink',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: initialRoute,
      onGenerateRoute: RouteGenerator.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}

class Singleton {
  // Accessible instance
  static final Singleton _instance = Singleton._internal();

  Singleton._internal();
  factory Singleton() => _instance;

  // Login
  // TODO

  // Home
  HashMap<int, Team>? teams = HashMap();
  int? teamId;

  void addTeam(String name, String modality) {
    teams ??= HashMap();
    int id = teams!.length + 1;
    teams![id] = Team(name, modality);
  }

  HashMap<int, Team>? getTeams() {
    return teams;
  }

  Team? getTeam(int? id) {
    return teams?[id];
  }

  int? getTeamCount() {
    return teams?.length;
  }

  // Calendar
  // TODO

  // Training
  // TODO

  HashMap<int, Train>? trains = HashMap();
  int? trainId;

  void addTrain(String name, String modality, int duration, List<Field> fields) {
    trains ??= HashMap();
    int id = trains!.length + 1;
    trains![id] = Train(name, modality, duration, fields);
  }

  HashMap<int, Train>? getTrains() {
    return trains;
  }

  Train? getTrain(int? id) {
    return trains?[id];
  }

  int? getTrainCount() {
    return trains?.length;
  }


}

class Team {
  final String name, modality;
  Team(this.name, this.modality);
}

class Train {
  final String name, modality;
  final int duration;
  final List<Field> fields;

  Train(this.name, this.modality, this.duration, this.fields);
}

class Field {
  final String name, description;
  final String field;

  Field(this.name, this.description, this.field);
}

