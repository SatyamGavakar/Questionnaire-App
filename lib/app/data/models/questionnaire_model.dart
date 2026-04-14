class QuestionModel {
  QuestionModel({
    required this.id,
    required this.question,
    required this.options,
  });

  final String id;
  final String question;
  final List<String> options;
}

class QuestionnaireModel {
  QuestionnaireModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
  });

  final String id;
  final String title;
  final String description;
  final List<QuestionModel> questions;
}
