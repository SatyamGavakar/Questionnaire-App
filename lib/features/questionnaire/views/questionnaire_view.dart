import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:questionnaire_app/features/questionnaire/controllers/questionnaire_controller.dart';

class QuestionnaireView extends GetView<QuestionnaireController> {
  const QuestionnaireView({super.key});

  @override
  Widget build(BuildContext context) {
    final model = controller.questionnaire;
    return Scaffold(
      appBar: AppBar(title: Text(model.title)),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: model.questions.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final question = model.questions[index];
                  return Card(
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
                          ...question.options.map(
                            (option) => Obx(
                              () => Padding(
                                padding: const EdgeInsets.only(bottom: 8),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(12),
                                  onTap: () =>
                                      controller.selectAnswer(question.id, option),
                                  child: Container(
                                    width: double.infinity,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 11,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: controller.selectedAnswers[question.id] ==
                                                option
                                            ? Theme.of(context).colorScheme.primary
                                            : Theme.of(context).colorScheme.outlineVariant,
                                      ),
                                      color: controller.selectedAnswers[question.id] ==
                                              option
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primaryContainer
                                              .withValues(alpha: 0.35)
                                          : Colors.transparent,
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          controller.selectedAnswers[question.id] == option
                                              ? Icons.radio_button_checked
                                              : Icons.radio_button_off,
                                          size: 20,
                                          color: controller.selectedAnswers[question.id] ==
                                                  option
                                              ? Theme.of(context).colorScheme.primary
                                              : Theme.of(context).colorScheme.onSurfaceVariant,
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(child: Text(option)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              child: SizedBox(
                width: double.infinity,
                child: Obx(
                  () => FilledButton(
                    onPressed: controller.isSubmitting.value ? null : controller.submit,
                    child: controller.isSubmitting.value
                        ? const SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('Submit'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
