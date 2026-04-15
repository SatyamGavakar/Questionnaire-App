class SubmissionModel {
  SubmissionModel({
    this.id,
    required this.userId,
    required this.questionnaireId,
    required this.dateTime,
    required this.latitude,
    required this.longitude,
  });

  final int? id;
  final String userId;
  final String questionnaireId;
  final DateTime dateTime;
  final double latitude;
  final double longitude;

  factory SubmissionModel.fromMap(Map<String, dynamic> map) {
    return SubmissionModel(
      id: map['id'] as int?,
      userId: (map['userId'] ?? '') as String,
      questionnaireId: map['questionnaireId'] as String,
      dateTime: DateTime.parse(map['dateTime'] as String),
      latitude: (map['latitude'] as num).toDouble(),
      longitude: (map['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'userId': userId,
        'questionnaireId': questionnaireId,
        'dateTime': dateTime.toIso8601String(),
        'latitude': latitude,
        'longitude': longitude,
      };
}
