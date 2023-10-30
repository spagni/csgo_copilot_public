import 'package:firebase_analytics/firebase_analytics.dart';

import 'package:meta/meta.dart';

class AnalyticsHelper {
  final FirebaseAnalytics analytics;

  AnalyticsHelper(this.analytics) : assert(analytics != null);

  void logEvent({@required String event, Map<String, dynamic> params}) {
    analytics.logEvent(name: event, parameters: params);
  }

  void logAppOpen() {
    analytics.logAppOpen();
  }
}
