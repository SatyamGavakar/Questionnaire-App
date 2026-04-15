import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:questionnaire_app/app/data/models/questionnaire_model.dart';
import 'package:questionnaire_app/core/widgets/app_empty_state.dart';
import 'package:questionnaire_app/features/home/controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Questionnaires'),
        actions: [
          IconButton(
            tooltip: 'Logout',
            onPressed: controller.confirmLogout,
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.selectedTab.value,
          children: [
            _DashboardTab(controller: controller),
            _HistoryTab(controller: controller),
            _ProfileTab(controller: controller),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.selectedTab.value,
          onDestinationSelected: controller.changeTab,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.grid_view_rounded),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.history_rounded),
              label: 'History',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_rounded),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class _DashboardTab extends StatelessWidget {
  const _DashboardTab({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.questionnaires.isEmpty) {
        return const AppEmptyState(
          title: 'No questionnaires',
          subtitle: 'Questionnaires will appear here when available.',
        );
      }
      return ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.primary,
                  Theme.of(context).colorScheme.primary,
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, ${controller.userName}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Complete questionnaires and capture submissions with location.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text('Available Questionnaires', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          ...controller.questionnaires.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _QuestionnaireCard(
                model: item,
                isSubmitted: controller.submittedQuestionnaireIds.contains(item.id),
                onTap: controller.submittedQuestionnaireIds.contains(item.id)
                    ? () => controller.openSubmittedQuestionnaire(item)
                    : () => controller.openQuestionnaire(item),
              ),
            ),
          ),
        ],
      );
    });
  }
}

class _HistoryTab extends StatelessWidget {
  const _HistoryTab({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.loadSubmissions,
      child: Obx(() {
        if (controller.isLoadingSubmissions.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.submissions.isEmpty) {
          return ListView(
            children: [
              const SizedBox(
                height: 420,
                child: AppEmptyState(
                  title: 'No submissions yet',
                  subtitle: 'Submit a questionnaire to see history.',
                ),
              ),
            ],
          );
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: controller.submissions.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final item = controller.submissions[index];
            final questionnaire = controller.questionnaires
                .firstWhereOrNull((q) => q.id == item.questionnaireId);
            return Card(
              child: ListTile(
                onTap: questionnaire == null
                    ? null
                    : () => controller.openSubmissionReview(
                          questionnaire: questionnaire,
                          submission: item,
                        ),
                leading: CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                  child: const Icon(Icons.assignment_turned_in_outlined),
                ),
                title: Text(
                  questionnaire == null
                      ? 'Questionnaire: ${item.questionnaireId.toUpperCase()}'
                      : questionnaire.title,
                ),
                subtitle: Text(
                  '${DateFormat.yMMMd().add_jm().format(item.dateTime)}\n'
                  'Lat ${item.latitude.toStringAsFixed(5)}, Lng ${item.longitude.toStringAsFixed(5)}',
                ),
                trailing: questionnaire == null
                    ? null
                    : const Icon(Icons.chevron_right_rounded),
              ),
            );
          },
        );
      }),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  const _ProfileTab({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ListView(
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
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.userName,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          controller.userPhone,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 3),
                        Text(
                          controller.userEmail,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.analytics_outlined),
                  const SizedBox(width: 10),
                  Text(
                    'Total submissions: ${controller.submissions.length}',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuestionnaireCard extends StatelessWidget {
  const _QuestionnaireCard({
    required this.model,
    required this.onTap,
    required this.isSubmitted,
  });

  final QuestionnaireModel model;
  final VoidCallback? onTap;
  final bool isSubmitted;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                    child: const Icon(Icons.fact_check_outlined, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      model.title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  if (isSubmitted)
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.tertiaryContainer,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        'Submitted',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onTertiaryContainer,
                              fontWeight: FontWeight.w700,
                            ),
                      ),
                    )
                  else
                    const Icon(Icons.chevron_right_rounded),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                model.description,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
