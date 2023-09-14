import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/routes/home.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

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
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: AppColors.black,
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const GatewayFenceEmployeeApp());
}

class GatewayFenceEmployeeApp extends StatelessWidget {
  const GatewayFenceEmployeeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gateway Fence Employee App',
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: HomeRoute(),
    );
  }
}
