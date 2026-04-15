import 'package:get/get.dart';
import 'package:questionnaire_app/app/data/models/questionnaire_model.dart';

class QuestionnaireService extends GetxService {
  List<QuestionnaireModel> getQuestionnaires() {
    return [
      QuestionnaireModel(
        id: 'q1',
        title: 'Customer Feedback',
        description: 'Understand how users feel about product quality.',
        questions: _customerFeedbackQuestions,
      ),
      QuestionnaireModel(
        id: 'q2',
        title: 'Field Visit Survey',
        description: 'Capture on-ground insights from field operations.',
        questions: _fieldVisitQuestions,
      ),
      QuestionnaireModel(
        id: 'q3',
        title: 'Post-Event Check-in',
        description: 'Review attendee experience and event improvements.',
        questions: _postEventQuestions,
      ),
      QuestionnaireModel(
        id: 'q4',
        title: 'Employee Pulse',
        description: 'Quick check on morale, workload, and team support.',
        questions: _employeePulseQuestions,
      ),
      QuestionnaireModel(
        id: 'q5',
        title: 'Website Usability',
        description: 'Identify friction points in the website journey.',
        questions: _websiteUsabilityQuestions,
      ),
      QuestionnaireModel(
        id: 'q6',
        title: 'Training Feedback',
        description: 'Evaluate training clarity, pace, and usefulness.',
        questions: _trainingFeedbackQuestions,
      ),
    ];
  }

  final List<QuestionModel> _customerFeedbackQuestions = [
    QuestionModel(
      id: 'q1_1',
      question: 'How satisfied are you with the product overall?',
      options: ['Very satisfied', 'Satisfied', 'Neutral', 'Dissatisfied'],
    ),
    QuestionModel(
      id: 'q1_2',
      question: 'How would you rate the product quality?',
      options: ['Excellent', 'Good', 'Average', 'Poor'],
    ),
    QuestionModel(
      id: 'q1_3',
      question: 'How would you rate the value for money?',
      options: ['Excellent', 'Good', 'Fair', 'Poor'],
    ),
    QuestionModel(
      id: 'q1_4',
      question: 'How likely are you to recommend us to others?',
      options: ['Very likely', 'Likely', 'Not sure', 'Unlikely'],
    ),
    QuestionModel(
      id: 'q1_5',
      question: 'How quickly did you receive support (if needed)?',
      options: ['Very quickly', 'Quickly', 'Slowly', 'Did not need support'],
    ),
  ];

  final List<QuestionModel> _fieldVisitQuestions = [
    QuestionModel(
      id: 'q2_1',
      question: 'Was the site accessible and safe to enter?',
      options: ['Yes', 'Mostly', 'No', 'Not applicable'],
    ),
    QuestionModel(
      id: 'q2_2',
      question: 'Were the stakeholders available during the visit?',
      options: ['Fully available', 'Partially', 'Not available', 'N/A'],
    ),
    QuestionModel(
      id: 'q2_3',
      question: 'Did you capture all required photos/notes?',
      options: ['Yes', 'Most of them', 'No', 'N/A'],
    ),
    QuestionModel(
      id: 'q2_4',
      question: 'How accurate were the records found on-site?',
      options: ['Accurate', 'Some mismatches', 'Mostly incorrect', 'Unknown'],
    ),
    QuestionModel(
      id: 'q2_5',
      question: 'How long did the visit take compared to plan?',
      options: ['Shorter', 'On time', 'Slightly longer', 'Much longer'],
    ),
  ];

  final List<QuestionModel> _postEventQuestions = [
    QuestionModel(
      id: 'q3_1',
      question: 'How satisfied were you with the event overall?',
      options: ['Very satisfied', 'Satisfied', 'Neutral', 'Dissatisfied'],
    ),
    QuestionModel(
      id: 'q3_2',
      question: 'How would you rate the session content quality?',
      options: ['Excellent', 'Good', 'Average', 'Poor'],
    ),
    QuestionModel(
      id: 'q3_3',
      question: 'How was the event venue/online experience?',
      options: ['Great', 'Good', 'Okay', 'Poor'],
    ),
    QuestionModel(
      id: 'q3_4',
      question: 'Was the agenda timing appropriate?',
      options: ['Perfect', 'Slightly rushed', 'Slightly long', 'Too long'],
    ),
    QuestionModel(
      id: 'q3_5',
      question: 'Would you attend future events from us?',
      options: ['Definitely', 'Probably', 'Maybe', 'No'],
    ),
  ];

  final List<QuestionModel> _employeePulseQuestions = [
    QuestionModel(
      id: 'q4_1',
      question: 'How would you rate your workload this week?',
      options: ['Light', 'Manageable', 'Heavy', 'Overwhelming'],
    ),
    QuestionModel(
      id: 'q4_2',
      question: 'Do you feel supported by your team?',
      options: ['Always', 'Often', 'Sometimes', 'Rarely'],
    ),
    QuestionModel(
      id: 'q4_3',
      question: 'How clear are your priorities right now?',
      options: ['Very clear', 'Clear', 'Somewhat unclear', 'Unclear'],
    ),
    QuestionModel(
      id: 'q4_4',
      question: 'How satisfied are you with your work-life balance?',
      options: ['Very satisfied', 'Satisfied', 'Neutral', 'Dissatisfied'],
    ),
    QuestionModel(
      id: 'q4_5',
      question: 'How likely are you to recommend this workplace?',
      options: ['Very likely', 'Likely', 'Not sure', 'Unlikely'],
    ),
  ];

  final List<QuestionModel> _websiteUsabilityQuestions = [
    QuestionModel(
      id: 'q5_1',
      question: 'Was it easy to find what you were looking for?',
      options: ['Very easy', 'Easy', 'Somewhat hard', 'Very hard'],
    ),
    QuestionModel(
      id: 'q5_2',
      question: 'How fast did the pages load for you?',
      options: ['Very fast', 'Fast', 'Slow', 'Very slow'],
    ),
    QuestionModel(
      id: 'q5_3',
      question: 'Did anything feel confusing or unclear?',
      options: ['No', 'A little', 'Yes', 'Not sure'],
    ),
    QuestionModel(
      id: 'q5_4',
      question: 'How was the checkout/sign-up experience?',
      options: ['Smooth', 'Mostly smooth', 'Had issues', 'Did not use'],
    ),
    QuestionModel(
      id: 'q5_5',
      question: 'How likely are you to return to the website?',
      options: ['Very likely', 'Likely', 'Not sure', 'Unlikely'],
    ),
  ];

  final List<QuestionModel> _trainingFeedbackQuestions = [
    QuestionModel(
      id: 'q6_1',
      question: 'How clear was the trainer’s explanation?',
      options: ['Very clear', 'Clear', 'Somewhat unclear', 'Unclear'],
    ),
    QuestionModel(
      id: 'q6_2',
      question: 'How would you rate the training pace?',
      options: ['Too slow', 'Just right', 'Too fast', 'Varied a lot'],
    ),
    QuestionModel(
      id: 'q6_3',
      question: 'Were the examples relevant to your work?',
      options: ['Very relevant', 'Relevant', 'Somewhat', 'Not relevant'],
    ),
    QuestionModel(
      id: 'q6_4',
      question: 'How confident do you feel after the training?',
      options: ['Very confident', 'Confident', 'Unsure', 'Not confident'],
    ),
    QuestionModel(
      id: 'q6_5',
      question: 'Would you recommend this training to others?',
      options: ['Definitely', 'Probably', 'Maybe', 'No'],
    ),
  ];
}
