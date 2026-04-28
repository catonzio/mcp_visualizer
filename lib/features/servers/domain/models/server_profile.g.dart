// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'server_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ServerProfile _$ServerProfileFromJson(Map<String, dynamic> json) =>
    _ServerProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      transportType: $enumDecode(_$TransportTypeEnumMap, json['transportType']),
      command: json['command'] as String?,
      args:
          (json['args'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      url: json['url'] as String?,
      headers:
          (json['headers'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      authTokenKey: json['authTokenKey'] as String?,
      lastConnectedAt: json['lastConnectedAt'] == null
          ? null
          : DateTime.parse(json['lastConnectedAt'] as String),
    );

Map<String, dynamic> _$ServerProfileToJson(_ServerProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'transportType': _$TransportTypeEnumMap[instance.transportType]!,
      'command': instance.command,
      'args': instance.args,
      'url': instance.url,
      'headers': instance.headers,
      'authTokenKey': instance.authTokenKey,
      'lastConnectedAt': instance.lastConnectedAt?.toIso8601String(),
    };

const _$TransportTypeEnumMap = {
  TransportType.stdio: 'stdio',
  TransportType.sse: 'sse',
  TransportType.streamableHttp: 'streamableHttp',
};
