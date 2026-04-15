import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:questionnaire_app/app/data/models/questionnaire_model.dart';
import 'package:questionnaire_app/app/data/models/submission_model.dart';

class SubmissionDetailsView extends StatelessWidget {
  const SubmissionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>? ?? {};
    final questionnaire = args['questionnaire'] as QuestionnaireModel?;
    final submission = args['submission'] as SubmissionModel?;

    if (questionnaire == null || submission == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Submission Details')),
        body: const Center(
          child: Text('Submission details are not available.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(questionnaire.title)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Submitted on ${DateFormat.yMMMd().add_jm().format(submission.dateTime)}',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Lat ${submission.latitude.toStringAsFixed(5)}, Lng ${submission.longitude.toStringAsFixed(5)}',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          ...questionnaire.questions.asMap().entries.map((entry) {
            final index = entry.key;
            final question = entry.value;
            final answer =
                submission.answers[question.id]?.trim().isNotEmpty == true
                ? submission.answers[question.id]!
                : 'No answer available';
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${index + 1}. ${question.question}',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Theme.of(context).colorScheme.primaryContainer
                              .withValues(alpha: 0.35),
                        ),
                        child: Text(answer),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
