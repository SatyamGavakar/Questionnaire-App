import 'package:get/get.dart';
import 'package:questionnaire_app/app/data/models/questionnaire_model.dart';

class QuestionnaireService extends GetxService {
  List<QuestionnaireModel> getQuestionnaires() {
    return [
      QuestionnaireModel(
        id: 'q1',
        title: 'Customer Feedback',
        description: 'Understand how users feel about product quality.',
        questions: _questions,
      ),
      QuestionnaireModel(
        id: 'q2',
        title: 'Field Visit Survey',
        description: 'Capture on-ground insights from field operations.',
        questions: _questions,
      ),
      QuestionnaireModel(
        id: 'q3',
        title: 'Post-Event Check-in',
        description: 'Review attendee experience and event improvements.',
        questions: _questions,
      ),
    ];
  }

  final List<QuestionModel> _questions = [
    QuestionModel(
      id: '1',
      question: 'How satisfied are you with the overall experience?',
      options: ['Very satisfied', 'Satisfied', 'Neutral', 'Dissatisfied'],
    ),
    QuestionModel(
      id: '2',
      question: 'How would you rate the quality of service?',
      options: ['Excellent', 'Good', 'Average', 'Poor'],
    ),
    QuestionModel(
      id: '3',
      question: 'Was the process easy to complete?',
      options: ['Very easy', 'Easy', 'Somewhat difficult', 'Difficult'],
    ),
    QuestionModel(
      id: '4',
      question: 'How likely are you to recommend this to others?',
      options: ['Very likely', 'Likely', 'Not sure', 'Unlikely'],
    ),
    QuestionModel(
      id: '5',
      question: 'Would you participate again in the future?',
      options: ['Definitely', 'Probably', 'Maybe', 'No'],
    ),
  ];
}
