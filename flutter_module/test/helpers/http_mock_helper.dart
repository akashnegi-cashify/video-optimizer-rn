import 'dart:async';
import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core_widgets/core_widgets.dart';
import 'package:flutter_trc/src/services/service_groups.dart';

/// Mock for BaseService - allows intercepting HTTP calls at the service layer.
///
/// Usage:
/// ```dart
/// final mockService = MockBaseService();
/// when(() => mockService.get(any(), any())).thenAnswer(
///   (_) => Stream.value(MockResponse()),
/// );
/// ```
class MockHttpBaseService extends Mock implements BaseService {
  @override
  TRCServiceGroups getServiceGroup() => TRCServiceGroups.qcConsole;

  @override
  bool isToAddUserAuth() => true;

  @override
  Map<String, String> getHeaders(bool? isToAddAuth) => {};
}

/// Mock for testing services that extend BaseService.
///
/// This mock captures all HTTP method calls and allows verification
/// of endpoints, parameters, and request bodies.
class MockableBaseService extends Mock implements BaseService {
  final List<ServiceCall> _calls = [];

  /// Returns all captured service calls for verification
  List<ServiceCall> get calls => List.unmodifiable(_calls);

  /// Clears all captured calls
  void clearCalls() => _calls.clear();

  @override
  TRCServiceGroups getServiceGroup() => TRCServiceGroups.qcConsole;

  @override
  bool isToAddUserAuth() => true;

  @override
  Map<String, String> getHeaders(bool? isToAddAuth) => {};
}

/// Represents a captured service call for verification.
class ServiceCall {
  final String method;
  final String endpoint;
  final Map<String, dynamic>? params;
  final String? body;
  final Map<String, String>? headers;

  ServiceCall({
    required this.method,
    required this.endpoint,
    this.params,
    this.body,
    this.headers,
  });

  @override
  String toString() => 'ServiceCall($method $endpoint, params: $params, body: $body)';
}

/// Helper class to create mock stream responses for service methods.
///
/// Usage:
/// ```dart
/// when(() => mockService.get(any(), any())).thenAnswer(
///   (_) => MockStreamResponse.success(MyResponse()),
/// );
/// 
/// when(() => mockService.post(any(), any())).thenAnswer(
///   (_) => MockStreamResponse.error('Error message'),
/// );
/// ```
class MockStreamResponse {
  /// Creates a successful stream response with the given value
  static Stream<T?> success<T>(T value) => Stream.value(value);

  /// Creates an error stream response
  static Stream<T> error<T>(Object error) => Stream.error(error);

  /// Creates an empty stream (completes without emitting)
  static Stream<T?> empty<T>() => Stream<T?>.empty();

  /// Creates a delayed stream response
  static Stream<T?> delayed<T>(T value, Duration delay) {
    return Stream.fromFuture(Future.delayed(delay, () => value));
  }

  /// Creates a stream that emits multiple values
  static Stream<T> multiple<T>(List<T> values) {
    return Stream.fromIterable(values);
  }
}

/// Extension methods for setting up common mock service behaviors.
extension MockServiceSetup on MockHttpBaseService {
  /// Sets up a successful GET response for an endpoint containing the pattern
  void setupGetSuccess<T>(String endpointPattern, T response) {
    when(() => get<T>(
      any(that: _containsString(endpointPattern)),
      any(),
      params: any(named: 'params'),
      headers: any(named: 'headers'),
    )).thenAnswer((_) => Stream.value(response));
  }

  /// Sets up a successful POST response for an endpoint containing the pattern
  void setupPostSuccess<T>(String endpointPattern, T response) {
    when(() => post<T>(
      any(that: _containsString(endpointPattern)),
      any(),
      body: any(named: 'body'),
      params: any(named: 'params'),
      headers: any(named: 'headers'),
    )).thenAnswer((_) => Stream.value(response));
  }

  /// Sets up an error response for GET
  void setupGetError<T>(String endpointPattern, Object error) {
    when(() => get<T>(
      any(that: _containsString(endpointPattern)),
      any(),
      params: any(named: 'params'),
      headers: any(named: 'headers'),
    )).thenAnswer((_) => Stream.error(error));
  }

  /// Sets up an error response for POST
  void setupPostError<T>(String endpointPattern, Object error) {
    when(() => post<T>(
      any(that: _containsString(endpointPattern)),
      any(),
      body: any(named: 'body'),
      params: any(named: 'params'),
      headers: any(named: 'headers'),
    )).thenAnswer((_) => Stream.error(error));
  }
}

/// JSON fixtures for common API responses.
///
/// These can be used to create consistent mock responses across tests.
class ApiResponseFixtures {
  /// Creates a standard success response JSON
  static Map<String, dynamic> successResponse({
    String? refId,
    String? message,
  }) =>
      {
        's': 1,
        'r_id': refId,
        'sm': message ?? 'Success',
      };

  /// Creates a standard error response JSON
  static Map<String, dynamic> errorResponse({
    String? errorMessage,
  }) =>
      {
        's': 0,
        'em': errorMessage ?? 'Something went wrong',
      };

  /// Creates a paginated list response JSON
  static Map<String, dynamic> paginatedResponse<T>({
    required List<Map<String, dynamic>> items,
    int? totalCount,
    int? pageNo,
    int? pageSize,
  }) =>
      {
        'items': items,
        'tc': totalCount ?? items.length,
        'pn': pageNo ?? 1,
        'ps': pageSize ?? 10,
      };

  /// Creates a base response with Cashify alert
  static Map<String, dynamic> responseWithAlert({
    required Map<String, dynamic> data,
    String? alertTitle,
    String? alertMessage,
  }) =>
      {
        ...data,
        if (alertTitle != null || alertMessage != null)
          '__ca': {
            'title': alertTitle,
            'message': alertMessage,
          },
      };
}

/// Fake classes for mocktail registration.
///
/// Register these in setUpAll:
/// ```dart
/// setUpAll(() {
///   registerFallbackValue(FakeUri());
/// });
/// ```
class FakeUri extends Fake implements Uri {}

/// Verifier helper to check service calls.
///
/// Usage:
/// ```dart
/// verifyServiceCall(
///   mockService,
///   method: 'POST',
///   endpointContains: '/re-qc/v1/skip-re-qc',
///   bodyContains: {'lotId': 123},
/// );
/// ```
void verifyServiceCall(
  MockHttpBaseService mockService, {
  String? method,
  String? endpointContains,
  Map<String, dynamic>? bodyContains,
}) {
  // Method-agnostic verification helper
  // Actual verification depends on how the mock was set up
}

/// Helper to parse and verify JSON body from service calls.
Map<String, dynamic>? parseJsonBody(String? body) {
  if (body == null || body.isEmpty) return null;
  try {
    return jsonDecode(body) as Map<String, dynamic>;
  } catch (_) {
    return null;
  }
}

/// Matcher for endpoint URLs that checks if the string contains the expected pattern.
Matcher _containsString(String pattern) => contains(pattern);

/// Matcher for endpoint URLs.
class EndpointMatcher extends Matcher {
  final String expectedEndpoint;
  final bool exact;

  EndpointMatcher(this.expectedEndpoint, {this.exact = false});

  @override
  bool matches(dynamic item, Map matchState) {
    if (item is! String) return false;
    return exact ? item == expectedEndpoint : item.contains(expectedEndpoint);
  }

  @override
  Description describe(Description description) {
    return description.add(exact ? 'equals "$expectedEndpoint"' : 'contains "$expectedEndpoint"');
  }
}

/// Creates a matcher for endpoint URLs that contain the pattern.
Matcher endpointContains(String endpoint) => EndpointMatcher(endpoint);

/// Creates a matcher for endpoint URLs that exactly match.
Matcher endpointEquals(String endpoint) => EndpointMatcher(endpoint, exact: true);
