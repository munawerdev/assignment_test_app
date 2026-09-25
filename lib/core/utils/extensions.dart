import 'package:material_ui/material_ui.dart';

// ==================== BUILDCONTEXT EXTENSIONS ====================

extension BuildContextExtension on BuildContext {
  // Theme & Colors
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;
  bool get isLandscape =>
      MediaQuery.orientationOf(this) == Orientation.landscape;

  // Keyboard & Input
  bool get isKeyboardVisible => MediaQuery.of(this).viewInsets.bottom > 0;
  void hideKeyboard() => FocusScope.of(this).unfocus();
}
