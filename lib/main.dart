import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:trainlink/route_generator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TrainLink',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      initialRoute: "/",
      onGenerateRoute: RouteGenerator.generateRoute,
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
}

class Team {
  final String name, modality;
  Team(this.name, this.modality);
}