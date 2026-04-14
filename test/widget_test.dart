import 'package:flutter_test/flutter_test.dart';
import 'package:questionnaire_app/app/app.dart';

void main() {
  testWidgets('App boots into splash', (WidgetTester tester) async {
    await tester.pumpWidget(const QuestionnaireApp());
    await tester.pump();
    expect(find.text('Questionnaire App'), findsOneWidget);
  });
}
