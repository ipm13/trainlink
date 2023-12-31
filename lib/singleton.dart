import 'dart:collection';

import 'package:intl/intl.dart';

class Singleton {
  // Accessible instance
  static final Singleton _instance = Singleton._internal();

  Singleton._internal();
  factory Singleton() => _instance;

  // Users

  HashMap<int, UserDTO>? users = HashMap();
  int? userId;

  void createUser(UserDTO user) {
    users ??= HashMap();
    int id = users!.length + 1;
    users![id] = user;
  }

  UserDTO? getUser(int? id) {
    return users?[id];
  }

  UserDTO? getUserByEmail(String email) {
    try {
      return users?.values.firstWhere((user) => user.email == email);
    } catch(e) {
      return null;
    }
  }

  // Teams

  HashMap<int, TeamDTO>? teams = HashMap();
  int? teamId;

  void addTeam(String name, String modality, String coachName, String? logoPath) {
    teams ??= HashMap();
    int id = teams!.length + 1;
    teams![id] = TeamDTO("7b640ac5-ea97-45d$id", name, modality, coachName, logoPath);
  }

  HashMap<int, TeamDTO>? getTeams() {
    return teams;
  }

  TeamDTO? getTeam(int? id) {
    return teams?[id];
  }

  int? getTeamCount() {
    return teams?.length;
  }

  // Calendar / Schedules

  HashMap<int, ScheduleDTO>? schedules = HashMap();
  int? scheduleId;

  void addSchedule(String teamName, String trainingName, String location, String weekDay, int hours, int minutes) {
    schedules ??= HashMap();
    int id = schedules!.length + 1;
    schedules![id] = ScheduleDTO(id, teamName, location, weekDay, hours, minutes, getTrainingByName(trainingName), true);
  }

  HashMap<int, ScheduleDTO>? getSchedules() {
    return schedules;
  }

  ScheduleDTO? getSchedule(int? id) {
    return schedules?[id];
  }

  void cancelSchedule(int? id) {
    schedules?[id]?.attendance = false;
  }

  List<ScheduleDTO> getSchedulesByWeekDay(String weekDay) {
    List<ScheduleDTO> resultSchedules = [];
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

  String modality = "Soccer";

  // Trainings

  HashMap<int, TrainingDTO>? trainings = HashMap();
  int? trainingId;

  void addTraining(String name, String modality, int duration, List<FieldDTO> fields) {
    trainings ??= HashMap();
    int id = trainings!.length + 1;
    trainings![id] = TrainingDTO(name, modality, duration, fields);
  }

  HashMap<int, TrainingDTO>? getTrainings() {
    return trainings;
  }

  TrainingDTO? getTraining(int? id) {
    return trainings?[id];
  }

  TrainingDTO? getTrainingByName(String name) {
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

UserDTO coachDefault = UserDTO("João Lázaro", "joao@gmail.com", "Password1@", DateFormat('dd MMMM yyyy').format(DateTime(1980)), "Male", "987654321", "Coach", "default");
UserDTO playerDefault = UserDTO("Leandro Santos", "leandro@gmail.com", "Password1@", DateFormat('dd MMMM yyyy').format(DateTime(2000)), "Male", "912345678", "Player", "default");

class UserDTO {
  final String name, email, password, birthDate, gender, mobilePhone, role, photo;
  UserDTO(this.name, this.email, this.password, this.birthDate, this.gender, this.mobilePhone, this.role, this.photo);
}

TeamDTO teamDefault = TeamDTO("7b640ac5-ea97-45d0", "Best FC", "Soccer", coachDefault.name, null);

class TeamDTO {
  final String code, name, modality, coachName;
  final String? logoPath;
  TeamDTO(this.code, this.name, this.modality, this.coachName, this.logoPath);
}

class TrainingDTO {
  final String name, modality;
  final int duration;
  final List<FieldDTO> fields;

  TrainingDTO(this.name, this.modality, this.duration, this.fields);
}

class ScheduleDTO {
  final int id;
  final String teamName, location, weekDay;
  final int hours, minutes;
  final TrainingDTO? training;
  late bool? attendance;

  ScheduleDTO(this.id, this.teamName, this.location, this.weekDay, this.hours, this.minutes, this.training, this.attendance);
}

class FieldDTO {
  final String name, description;
  final String field;

  FieldDTO(this.name, this.description, this.field);
}

