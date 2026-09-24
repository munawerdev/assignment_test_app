import 'package:assignment_test_app/features/bottom_nav/bottom_nav_initial_params.dart';
import 'package:assignment_test_app/features/bottom_nav/bottom_nav_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart'
    as flutter_localizations;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';

import '/config/theme/theme_data.dart';
import '/core/constants/global.dart';
import '/core/show/checker_navigator_observer.dart';
import '/injection_container.dart' as di;
import '/injection_container.dart';

Future<void> main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ScreenUtilInit(
    designSize: const Size(375, 812),
    minTextAdapt: true,
    splitScreenMode: true,
    builder: (_, child) => MaterialApp(
      navigatorKey: GlobalConstants.navigatorKey,
      scaffoldMessengerKey: GlobalConstants.scaffoldMessengerKey,
      navigatorObservers: [CheckerNavigatorObserver()],
      localizationsDelegates:
          flutter_localizations.GlobalMaterialLocalizations.delegates,
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      home: BottomNavPage(cubit: getIt(param1: const BottomNavInitialParams())),
    ),
  );
}
