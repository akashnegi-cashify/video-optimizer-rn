// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsResponse _$UserDetailsResponseFromJson(Map<String, dynamic> json) => UserDetailsResponse(
      firstName: json['firstName'] as String?,
      listOfRoles: (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList(),
      mobileNumber: json['mobile'] as String?,
      role: json['role'] as String?,
      uid: json['uid'] as String?,
      userName: json['userName'] as String?,
      mobileMd5: json['mobileMd5'] as String?,
    );

Map<String, dynamic> _$UserDetailsResponseToJson(UserDetailsResponse instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'mobile': instance.mobileNumber,
      'uid': instance.uid,
      'role': instance.role,
      'userName': instance.userName,
      'roles': instance.listOfRoles,
      'mobileMd5': instance.mobileMd5,
    };
