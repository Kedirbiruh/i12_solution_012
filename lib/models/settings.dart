import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings.freezed.dart';

@freezed
abstract class Settings with _$Settings {
  const factory Settings({
    @Default(false) bool isDarkMode,
    @Default(true) bool askConfirmationBeforeDelete,
  }) = _Settings;
}
