import 'dart:convert';

class SubmissionModel {
  SubmissionModel({
    this.id,
    required this.userId,
    required this.questionnaireId,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
    required this.answers,
  });

  final int? id;
  final String userId;
  final String questionnaireId;
  final DateTime dateTime;
  final double latitude;
  final double longitude;
  final Map<String, String> answers;

  factory SubmissionModel.fromMap(Map<String, dynamic> map) {
    return SubmissionModel(
      id: map['id'] as int?,
      userId: (map['userId'] ?? '') as String,
      questionnaireId: map['questionnaireId'] as String,
      dateTime: DateTime.parse(map['dateTime'] as String),
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
      answers: _parseAnswers(map['answersJson']),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'questionnaireId': questionnaireId,
        'dateTime': dateTime.toIso8601String(),
        'latitude': latitude,
        'longitude': longitude,
        'answersJson': jsonEncode(answers),
      };

  static Map<String, String> _parseAnswers(dynamic rawValue) {
    if (rawValue is! String || rawValue.isEmpty) {
      return <String, String>{};
    }
    final decoded = jsonDecode(rawValue);
    if (decoded is! Map<String, dynamic>) {
      return <String, String>{};
    }
    return decoded.map(
      (key, value) => MapEntry(key, value?.toString() ?? ''),
    );
  }
}
