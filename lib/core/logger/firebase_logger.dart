import 'package:firebase_analytics/firebase_analytics.dart';

void firebaseLogger(String event, String title) {
  switch (event) {
    case 'addLog':
      FirebaseAnalytics.instance
          .logEvent(name: 'add_todo', parameters: {'full_text': title});
      break;
    case 'deleteLog':
      FirebaseAnalytics.instance.logEvent(
        name: 'delete_todo',
        parameters: {'full_text': title},
      );
      break;
    case 'completeLog':
      FirebaseAnalytics.instance.logEvent(
        name: 'complete_todo',
        parameters: {'full_text': title},
      );
      break;
  }
}
