import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/timer_provider.dart';
import 'package:gateway_fence_employee/routes/home.dart';
import 'package:gateway_fence_employee/routes/time_sheet.dart';

// Application variables
const appVarEnvironment = String.fromEnvironment(
  'APPLICATION_ENVIRONMENT',
  defaultValue: 'release',
);
const appVarLogLevel = String.fromEnvironment(
  'APPLICATION_LOG_LEVEL',
  defaultValue: 'error',
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: AppColors.black,
  ));

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Timer()),
  ], child: const GatewayFenceEmployeeApp()));
}

class GatewayFenceEmployeeApp extends StatelessWidget {
  const GatewayFenceEmployeeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gateway Fence Employee App',
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (BuildContext context) => const HomeRoute(),
        '/time-sheet': (BuildContext context) => TimeSheetRoute(),
      },
      themeAnimationDuration: const Duration(milliseconds: 0),
    );
  }
}
