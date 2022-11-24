import 'common_events.dart';

class PageViewEvent extends CommonEvents {
  final String eventName;

  PageViewEvent(this.eventName);

  @override
  String getKey() {
    return eventName;
  }
}
