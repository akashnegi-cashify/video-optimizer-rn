// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsResponse _$UserDetailsResponseFromJson(Map<String, dynamic> json) =>
    UserDetailsResponse(
      clid: json['clid'] as String?,
      clv: json['clv'] as String?,
      exp: (json['exp'] as num?)?.toInt(),
      firstName: json['fname'] as String?,
      gt: json['gt'] as String?,
      kid: json['kid'] as String?,
      listOfRoles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      mobileNumber: json['mn'] as String?,
      role: json['role'] as String?,
      uid: json['uid'] as String?,
      userName: json['uname'] as String?,
      vt: (json['vt'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserDetailsResponseToJson(
        UserDetailsResponse instance) =>
    <String, dynamic>{
      'fname': instance.firstName,
      'mn': instance.mobileNumber,
      'uid': instance.uid,
      'role': instance.role,
      'uname': instance.userName,
      'kid': instance.kid,
      'roles': instance.listOfRoles,
      'clid': instance.clid,
      'clv': instance.clv,
      'exp': instance.exp,
      'gt': instance.gt,
      'vt': instance.vt,
    };
