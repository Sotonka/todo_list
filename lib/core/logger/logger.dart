import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:logger/logger.dart';

part 'logger.g.dart';

@riverpod
Logger appLogger(AppLoggerRef ref) {
  return Logger(
    printer: PrettyPrinter(),
  );
}
