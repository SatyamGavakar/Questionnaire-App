import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:questionnaire_app/core/widgets/app_empty_state.dart';
import 'package:questionnaire_app/features/profile/controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile & Activity')),
      body: RefreshIndicator(
        onRefresh: controller.loadSubmissions,
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                        child: Text(
                          controller.userName.isNotEmpty
                              ? controller.userName.characters.first.toUpperCase()
                              : '?',
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              controller.userName,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              controller.userPhone,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              'Total Submissions: ${controller.submissions.length}',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Submission History', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              if (controller.submissions.isEmpty)
                const SizedBox(
                  height: 200,
                  child: AppEmptyState(
                    title: 'No submissions yet',
                    subtitle: 'Your saved submissions will appear here.',
                  ),
                )
              else
                ...controller.submissions.map(
                  (item) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Card(
                      child: ListTile(
                        title: Text('Questionnaire: ${item.questionnaireId}'),
                        subtitle: Text(
                          '${DateFormat.yMMMd().add_jm().format(item.dateTime)}\n'
                          'Lat: ${item.latitude.toStringAsFixed(5)}, '
                          'Lng: ${item.longitude.toStringAsFixed(5)}',
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          );
        }),
      ),
    );
  }
}
