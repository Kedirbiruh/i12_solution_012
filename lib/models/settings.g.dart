// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Settings _$SettingsFromJson(Map<String, dynamic> json) => _Settings(
  isDarkMode: json['isDarkMode'] as bool? ?? false,
  askConfirmationBeforeDelete:
      json['askConfirmationBeforeDelete'] as bool? ?? true,
);

Map<String, dynamic> _$SettingsToJson(_Settings instance) => <String, dynamic>{
  'isDarkMode': instance.isDarkMode,
  'askConfirmationBeforeDelete': instance.askConfirmationBeforeDelete,
};
