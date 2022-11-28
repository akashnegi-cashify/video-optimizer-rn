import 'dart:convert';
import 'package:core/core.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/interceptors/auth/request_headers.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

abstract class TRCBaseService {
  Stream<T> get<T>(
    String endPoint,
    Function fromJson, {
    Map<String, List<String>>? params,
    Map<String, String>? addHeaders,
    Map<String, String>? headers,
    bool? isToAddAuth,
    bool? authorization,
  }) {
    Map<String, String>? allHeaders = headers ?? getHeaders(isToAddAuth);
    if (addHeaders != null) {
      allHeaders.addAll(addHeaders);
    }
    return HttpClient.get(
      endPoint,
      params: params,
      serviceGroup: getServiceGroup().value,
      authorization: authorization ?? isToAddAuthorization(),
      headers: allHeaders,
    ).map((event) {
      return fromJson(jsonDecode(event.body));
    });
  }

  Stream<List<T>> getArray<T>(
    String endPoint,
    Function fromJson, {
    Map<String, List<String>>? params,
    Map<String, String>? headers,
    bool? isToAddAuth,
    bool? authorization,
  }) {
    return HttpClient.get(
      endPoint,
      params: params,
      serviceGroup: getServiceGroup().value,
      authorization: authorization ?? isToAddAuthorization(),
      headers: headers ?? getHeaders(isToAddAuth),
    ).map((event) {
      return ArrayUtil.parseListItem(jsonDecode(event.body), fromJson);
    });
  }

  Stream<T> post<T>(
    String endPoint,
    Function fromJson, {
    body,
    Map<String, String>? headers,
    Map<String, String>? addHeaders,
    bool? userAuth,
    bool? authorization,
    Map<String, List<String>>? params,
  }) {
    Map<String, String>? allHeaders = headers ?? getHeaders(userAuth);
    allHeaders.putIfAbsent('content-type', () => 'application/json');
    if (addHeaders != null) {
      allHeaders.addAll(addHeaders);
    }
    return HttpClient.post(
      endPoint,
      body: body,
      params: params,
      serviceGroup: getServiceGroup().value,
      authorization: authorization ?? isToAddAuthorization(),
      headers: allHeaders,
    ).map((event) {
      return fromJson(jsonDecode(event.body));
    });
  }

  Stream<T> post_<T>(
    String endPoint, {
    Function? fromJson,
    body,
    Map<String, String>? headers,
    Map<String, String>? addHeaders,
    bool? userAuth,
    bool? authorization,
    Map<String, List<String>>? params,
  }) {
    Map<String, String>? allHeaders = headers ?? getHeaders(userAuth);
    allHeaders.putIfAbsent('content-type', () => 'application/json');
    if (addHeaders != null) {
      allHeaders.addAll(addHeaders);
    }
    return HttpClient.post(
      endPoint,
      body: body,
      params: params,
      serviceGroup: getServiceGroup().value,
      authorization: authorization ?? isToAddAuthorization(),
      headers: allHeaders,
    ).map((event) {
      return fromJson?.call(jsonDecode(event.body));
    });
  }

  Stream<List<T>> postArray<T>(
    String endPoint,
    Function fromJson, {
    body,
    Map<String, String>? headers,
    Map<String, String>? addHeaders,
    bool? userAuth,
    bool? authorization,
    Map<String, List<String>>? params,
  }) {
    Map<String, String>? allHeaders = headers ?? getHeaders(userAuth);
    allHeaders.putIfAbsent('content-type', () => 'application/json');
    if (addHeaders != null) {
      allHeaders.addAll(addHeaders);
    }
    return HttpClient.post(
      endPoint,
      body: body,
      params: params,
      serviceGroup: getServiceGroup().value,
      authorization: authorization ?? isToAddAuthorization(),
      headers: allHeaders,
    ).map((event) {
      return ArrayUtil.parseListItem(jsonDecode(event.body), fromJson);
    });
  }

  Stream<T> put<T>(
    String endPoint,
    Function fromJson, {
    body,
    Map<String, String>? headers,
    bool? userAuth,
    bool? authorization,
    Map<String, List<String>>? params,
  }) {
    return HttpClient.put(
      endPoint,
      body: body,
      params: params,
      serviceGroup: getServiceGroup().value,
      authorization: authorization ?? isToAddAuthorization(),
      headers: headers ?? getHeaders(userAuth)
        ..putIfAbsent('content-type', () => 'application/json'),
    ).map((event) {
      return fromJson(jsonDecode(event.body));
    });
  }

  Stream<T> delete<T>(
    String endPoint,
    Function fromJson, {
    body,
    Map<String, String>? headers,
    bool? userAuth,
    bool? authorization,
    Map<String, List<String>>? params,
  }) {
    return HttpClient.delete(
      endPoint,
      body: body,
      params: params,
      serviceGroup: getServiceGroup().value,
      authorization: authorization ?? isToAddAuthorization(),
      headers: headers ?? getHeaders(userAuth)
        ..putIfAbsent('content-type', () => 'application/json'),
    ).map((event) {
      return fromJson(jsonDecode(event.body));
    });
  }

  Stream<T> delete_<T>(
    String endPoint, {
    Function? fromJson,
    body,
    Map<String, String>? headers,
    bool? userAuth,
    bool? authorization,
    Map<String, List<String>>? params,
  }) {
    return HttpClient.delete(
      endPoint,
      body: body,
      params: params,
      serviceGroup: getServiceGroup().value,
      authorization: authorization ?? isToAddAuthorization(),
      headers: headers ?? getHeaders(userAuth)
        ..putIfAbsent('content-type', () => 'application/json'),
    ).map((event) {
      return fromJson?.call(jsonDecode(event.body) ?? jsonDecode(event.body));
    });
  }

  Map<String, String> getHeaders(bool? isToAddAuth) {
    return {
      ...(isToAddAuth ?? isToAddUserAuth()) ? AppHeaders.X_USER_AUTH : {},
    };
  }

  bool isToAddAuthorization() {
    return false;
  }

  bool isToAddUserAuth() {
    return true;
  }

  TRCServiceGroups getServiceGroup();
}
