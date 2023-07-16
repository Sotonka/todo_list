import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yandex_flutter_task/core/firebase_remote_config/firebase_remote_config.dart';

part 'event_repository.g.dart';

@riverpod
EventRepository eventRepository(EventRepositoryRef ref) {
  return EventRepository(
    firebaseRemoteConfigService:
        ref.watch(firebaseRemoteConfigServiceProvider), // add
  );
}

@riverpod
Future<String?> eventInfo(EventInfoRef ref) {
  return ref.watch(eventRepositoryProvider).getEventInfo();
}

class EventRepository {
  const EventRepository({
    required this.firebaseRemoteConfigService,
  });

  final FirebaseRemoteConfigService firebaseRemoteConfigService;

  Future<String?> getEventInfo() async {
    final importanceColor = firebaseRemoteConfigService.getImportanceColor();

    return importanceColor;
  }
}
