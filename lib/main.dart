import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/routes/home.dart';

// Application variables
const appVarEnvironment = String.fromEnvironment(
  'APPLICATION_ENVIRONMENT',
  defaultValue: 'release',
);
const appVarLogLevel = String.fromEnvironment(
  'APPLICATION_LOG_LEVEL',
  defaultValue: 'error',
);

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: AppColors.black,
  ));

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
