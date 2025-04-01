import 'package:intl/intl.dart';

class WeightEntity {
  int id;
  DateTime createdTime;
  int type;
  String weight;
  DateTime fastingTime;

  WeightEntity({
    required this.id,
    required this.createdTime,
    required this.type,
    required this.weight,
    required this.fastingTime,
  });

  factory WeightEntity.fromJson(Map<String, dynamic> json) {
    return WeightEntity(
      id: json['id'],
      createdTime: DateTime.parse(json['createdTime']),
      type: json['type'],
      weight: json['weight'],
      fastingTime: DateTime.parse(json['fastingTime']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdTime': createdTime.toIso8601String(),
      'type': type,
      'weight': weight,
      'fastingTime': fastingTime.toIso8601String(),
    };
  }

  String get createdTimeStr => DateFormat('MM/dd/yyyy').format(createdTime);

  String get createdTimeChartStr => DateFormat('dd/MM').format(createdTime);

  String get fastingTimeStr {
    final hours = fastingTime.hour;
    final minutes = fastingTime.minute;
    return '$hours h $minutes m';
  }
}
