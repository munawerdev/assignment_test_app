import 'package:material_ui/material_ui.dart';

abstract class GlobalConstants {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  static const apiKey = 'bc4e89a752a12eda8c4370f5d64ad31d';
}
