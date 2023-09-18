import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateway_fence_employee/screens/_util.dart';
import 'package:gateway_fence_employee/util/config.dart';

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/timer_provider.dart';

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
    ChangeNotifierProvider(create: (context) => Timer()),
    ChangeNotifierProvider(create: (context) => CurrentRouteProvider()),
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
      // routerDelegate: routerConfig.routerDelegate,
      // routeInformationParser: routerConfig.routeInformationParser,
      routerConfig: routerConfig,
      themeAnimationDuration: const Duration(milliseconds: 200),
    );
  }
}