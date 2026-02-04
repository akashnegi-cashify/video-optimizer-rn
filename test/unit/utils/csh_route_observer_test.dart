import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_trc/src/utils/csh_route_observer.dart';

void main() {
  group('CshRouteObserver', () {
    late CshRouteObserver observer;

    setUp(() {
      // Get fresh instance and clear the stack
      observer = CshRouteObserver();
      observer.pageRouteStack.clear();
    });

    group('singleton pattern', () {
      test('should return same instance on multiple calls', () {
        // Arrange & Act
        final instance1 = CshRouteObserver();
        final instance2 = CshRouteObserver();

        // Assert
        expect(identical(instance1, instance2), isTrue);
      });

      test('instance getter should return same instance', () {
        // Assert
        expect(identical(observer.instance, CshRouteObserver()), isTrue);
      });
    });

    group('pageRouteStack', () {
      test('should start with empty stack', () {
        // Assert
        expect(observer.pageRouteStack, isEmpty);
      });

      test('should be a list of PageRoute', () {
        // Assert
        expect(observer.pageRouteStack, isA<List<PageRoute<dynamic>>>());
      });
    });

    group('didPush', () {
      test('should add PageRoute to stack when pushed', () {
        // Arrange
        final route = _MockPageRoute(name: '/test');

        // Act
        observer.didPush(route, null);

        // Assert
        expect(observer.pageRouteStack.length, equals(1));
        expect(observer.pageRouteStack.last.settings.name, equals('/test'));
      });

      test('should not add non-PageRoute to stack', () {
        // Arrange
        final route = _MockNonPageRoute();

        // Act
        observer.didPush(route, null);

        // Assert
        expect(observer.pageRouteStack, isEmpty);
      });

      test('should add multiple routes to stack in order', () {
        // Arrange
        final route1 = _MockPageRoute(name: '/first');
        final route2 = _MockPageRoute(name: '/second');
        final route3 = _MockPageRoute(name: '/third');

        // Act
        observer.didPush(route1, null);
        observer.didPush(route2, route1);
        observer.didPush(route3, route2);

        // Assert
        expect(observer.pageRouteStack.length, equals(3));
        expect(observer.pageRouteStack[0].settings.name, equals('/first'));
        expect(observer.pageRouteStack[1].settings.name, equals('/second'));
        expect(observer.pageRouteStack[2].settings.name, equals('/third'));
      });
    });

    group('didPop', () {
      test('should remove route from stack when popped', () {
        // Arrange
        final route1 = _MockPageRoute(name: '/first');
        final route2 = _MockPageRoute(name: '/second');
        observer.didPush(route1, null);
        observer.didPush(route2, route1);

        // Act
        observer.didPop(route2, route1);

        // Assert
        expect(observer.pageRouteStack.length, equals(1));
        expect(observer.pageRouteStack.last.settings.name, equals('/first'));
      });

      test('should handle pop when stack is empty', () {
        // Arrange
        final route = _MockPageRoute(name: '/test');

        // Act & Assert - should not throw
        observer.didPop(route, null);
        expect(observer.pageRouteStack, isEmpty);
      });

      test('should not modify stack for non-PageRoute pop', () {
        // Arrange
        final pageRoute = _MockPageRoute(name: '/test');
        final nonPageRoute = _MockNonPageRoute();
        observer.didPush(pageRoute, null);

        // Act
        observer.didPop(nonPageRoute, pageRoute);

        // Assert
        expect(observer.pageRouteStack.length, equals(1));
      });
    });

    group('didRemove', () {
      test('should remove specific route from stack', () {
        // Arrange
        final route1 = _MockPageRoute(name: '/first');
        final route2 = _MockPageRoute(name: '/second');
        observer.didPush(route1, null);
        observer.didPush(route2, route1);

        // Act
        observer.didRemove(route1, null);

        // Assert - route1 should be removed, route2 should remain
        expect(observer.pageRouteStack.length, equals(1));
        expect(observer.pageRouteStack.last.settings.name, equals('/second'));
      });

      test('should handle remove when route not in stack', () {
        // Arrange
        final route1 = _MockPageRoute(name: '/first');
        final route2 = _MockPageRoute(name: '/second');
        observer.didPush(route1, null);

        // Act & Assert - should not throw
        observer.didRemove(route2, null);
        expect(observer.pageRouteStack.length, equals(1));
      });
    });

    group('didReplace', () {
      test('should replace last route in stack', () {
        // Arrange
        final route1 = _MockPageRoute(name: '/first');
        final route2 = _MockPageRoute(name: '/second');
        final newRoute = _MockPageRoute(name: '/replacement');
        observer.didPush(route1, null);
        observer.didPush(route2, route1);

        // Act
        observer.didReplace(newRoute: newRoute, oldRoute: route2);

        // Assert
        expect(observer.pageRouteStack.length, equals(2));
        expect(observer.pageRouteStack.last.settings.name, equals('/replacement'));
      });

      test('should not replace for non-PageRoute', () {
        // Arrange
        final route1 = _MockPageRoute(name: '/first');
        final nonPageRoute = _MockNonPageRoute();
        observer.didPush(route1, null);

        // Act - this should not modify the stack as newRoute is not PageRoute
        // The implementation only checks if newRoute is PageRoute
        observer.didReplace(newRoute: nonPageRoute, oldRoute: route1);

        // Assert
        expect(observer.pageRouteStack.length, equals(1));
        expect(observer.pageRouteStack.last.settings.name, equals('/first'));
      });
    });

    group('isRouteExist', () {
      test('should return true when route exists in stack', () {
        // Arrange
        final route = _MockPageRoute(name: '/existing');
        observer.didPush(route, null);

        // Act
        final result = observer.isRouteExist('/existing');

        // Assert
        expect(result, isTrue);
      });

      test('should return false when route does not exist', () {
        // Arrange
        final route = _MockPageRoute(name: '/existing');
        observer.didPush(route, null);

        // Act
        final result = observer.isRouteExist('/nonexistent');

        // Assert
        expect(result, isFalse);
      });

      test('should return false when stack is empty', () {
        // Act
        final result = observer.isRouteExist('/any');

        // Assert
        expect(result, isFalse);
      });

      test('should find route among multiple routes', () {
        // Arrange
        final route1 = _MockPageRoute(name: '/first');
        final route2 = _MockPageRoute(name: '/second');
        final route3 = _MockPageRoute(name: '/third');
        observer.didPush(route1, null);
        observer.didPush(route2, route1);
        observer.didPush(route3, route2);

        // Act & Assert
        expect(observer.isRouteExist('/first'), isTrue);
        expect(observer.isRouteExist('/second'), isTrue);
        expect(observer.isRouteExist('/third'), isTrue);
        expect(observer.isRouteExist('/fourth'), isFalse);
      });
    });

    group('isLastRouteIsNoInternet', () {
      test('should return true when last route matches no internet screen', () {
        // Arrange
        final route = _MockPageRoute(name: '/no_internet');
        observer.didPush(route, null);

        // Act
        final result = observer.isLastRouteIsNoInternet('/no_internet');

        // Assert
        expect(result, isTrue);
      });

      test('should return false when last route does not match', () {
        // Arrange
        final route = _MockPageRoute(name: '/home');
        observer.didPush(route, null);

        // Act
        final result = observer.isLastRouteIsNoInternet('/no_internet');

        // Assert
        expect(result, isFalse);
      });

      test('should return false when stack is empty', () {
        // Act
        final result = observer.isLastRouteIsNoInternet('/no_internet');

        // Assert
        expect(result, isFalse);
      });
    });
  });
}

/// Mock PageRoute for testing
class _MockPageRoute extends PageRoute<void> {
  final String? name;
  final Object? arguments;

  _MockPageRoute({this.name, this.arguments});

  @override
  RouteSettings get settings => RouteSettings(name: name, arguments: arguments);

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return const SizedBox();
  }

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);
}

/// Mock non-PageRoute for testing
class _MockNonPageRoute extends Route<void> {
  @override
  RouteSettings get settings => const RouteSettings(name: '/non_page');
}
