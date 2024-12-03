import 'package:hive_flutter/hive_flutter.dart';
part 'settings.g.dart';

@HiveType(typeId: 2)
class Settings {
  @HiveField(0)
  final bool isDarkTheme;

  @HiveField(1)
  final bool shouldSpeak;

  Settings({
    required this.isDarkTheme,
    required this.shouldSpeak,
  });
}
