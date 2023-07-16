import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:yandex_flutter_task/core/constants.dart';

void firebaseLogger(String event, String title) {
  switch (event) {
    case FirebaseLog.addLog:
      FirebaseAnalytics.instance
          .logEvent(name: 'add_todo', parameters: {'full_text': title});
      break;
    case FirebaseLog.deleteLog:
      FirebaseAnalytics.instance.logEvent(
        name: 'delete_todo',
        parameters: {'full_text': title},
      );
      break;
    case FirebaseLog.updateLog:
      FirebaseAnalytics.instance.logEvent(
        name: 'update_todo',
        parameters: {'full_text': title},
      );
      break;

    case FirebaseLog.routeLog:
      FirebaseAnalytics.instance.logEvent(
        name: 'route',
        parameters: {'route': title},
      );
      break;
  }
}
