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

  // Teams

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

  // Calendar / Schedules

  HashMap<int, Schedule>? schedules = HashMap();
  int? scheduleId;

  void addSchedule(String teamName, String trainingName, String location, String weekDay, int hours, int minutes) {
    schedules ??= HashMap();
    int id = schedules!.length + 1;
    schedules![id] = Schedule(teamName, location, weekDay, hours, minutes, getTrainingByName(trainingName));
  }

  HashMap<int, Schedule>? getSchedules() {
    return schedules;
  }

  Schedule? getSchedule(int? id) {
    return schedules?[id];
  }

  List<Schedule> getSchedulesByWeekDay(String weekDay) {
    List<Schedule> resultSchedules = [];
    schedules?.forEach((key, value) {
      if (value.weekDay.contains(weekDay)){
        resultSchedules.add(value);
      }
    });
    return resultSchedules;
  }

  int? getSchedulesCount() {
    return schedules?.length;
  }

  // Trainings

  HashMap<int, Training>? trainings = HashMap();
  int? trainingId;

  void addTraining(String name, String modality, int duration, List<Field> fields) {
    trainings ??= HashMap();
    int id = trainings!.length + 1;
    trainings![id] = Training(name, modality, duration, fields);
  }

  HashMap<int, Training>? getTrainings() {
    return trainings;
  }

  Training? getTraining(int? id) {
    return trainings?[id];
  }

  Training? getTrainingByName(String name) {
    for (final training in trainings!.values) {
      if (training.name == name) {
        return training;
      }
    }
    return null;
  }

  int? getTrainingCount() {
    return trainings?.length;
  }


}

class Team {
  final String name, modality;
  Team(this.name, this.modality);
}

class Training {
  final String name, modality;
  final int duration;
  final List<Field> fields;

  Training(this.name, this.modality, this.duration, this.fields);
}

class Schedule {
  final String teamName, location, weekDay;
  final int hours, minutes;
  final Training? training;

  Schedule(this.teamName, this.location, this.weekDay, this.hours, this.minutes, this.training);
}

class Field {
  final String name, description;
  final String field;

  Field(this.name, this.description, this.field);
}

