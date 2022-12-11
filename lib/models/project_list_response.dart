import 'package:equatable/equatable.dart';

class ProjectListResponse extends Equatable {
  const ProjectListResponse({required this.projects});

  factory ProjectListResponse.fromJson(List<dynamic> json) {
    final projects = <Project>[];
    for (var jsonElement in json) {
      projects.add(Project.fromJson(jsonElement));
    }
    return ProjectListResponse(projects: projects);
  }
  final List<Project> projects;

  @override
  List<Object?> get props => [projects];
}

class Project extends Equatable {
  const Project({
    required this.id,
    required this.projectId,
    required this.name,
    required this.description,
    required this.shortName,
    required this.masterSchedule,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['_id'],
      projectId: json['projectID'],
      name: json['name'],
      description: json['description'],
      shortName: json['shortName'],
      masterSchedule: json['masterSchedule'],
    );
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['_id'] = id;
    data['projectID'] = projectId;
    data['name'] = name;
    data['description'] = description;
    data['shortName'] = shortName;
    return data;
  }

  final String id;
  final String projectId;
  final String name;
  final String description;
  final String shortName;
  final String masterSchedule;

  @override
  List<Object?> get props => [id, name];
}

class ChatRoomSettings {
  ChatRoomSettings({
    required this.chatRoomId,
    required this.chatRoomName,
  });
  factory ChatRoomSettings.fromJson(Map<String, dynamic> json) =>
      ChatRoomSettings(
        chatRoomId: json['chatRoomId'],
        chatRoomName: json['chatRoomName'],
      );

  Map<String, dynamic> toJson() => {
        'chatRoomId': chatRoomId,
        'chatRoomName': chatRoomName,
      };

  final String chatRoomId;
  final String chatRoomName;
}
