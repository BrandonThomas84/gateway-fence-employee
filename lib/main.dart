import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/timer_provider.dart';
import 'package:gateway_fence_employee/routes/home.dart';
import 'package:gateway_fence_employee/routes/time_card.dart';

// Application variables
const appVarEnvironment = String.fromEnvironment(
  'APPLICATION_ENVIRONMENT',
  defaultValue: 'release',
);
const appVarLogLevel = String.fromEnvironment(
  'APPLICATION_LOG_LEVEL',
  defaultValue: 'error',
);
const companyName = String.fromEnvironment(
  'COMPANY_NAME',
  defaultValue: 'failboat',
);

Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: AppColors.black,
  ));

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseDatabase _ = FirebaseDatabase.instance;

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Timer()),
  ], child: const GatewayFenceEmployeeApp()));
}

class GatewayFenceEmployeeApp extends StatelessWidget {
  const GatewayFenceEmployeeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '$companyName App',
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        routes: [
          GoRoute(
            path: '/',
            builder: (context, state) => const HomeRoute(),
          ),
          GoRoute(
            path: '/time-card',
            builder: (context, state) => TimeCardRoute(),
          ),
        ],
      ),
      themeAnimationDuration: const Duration(milliseconds: 200),
    );
  }
}