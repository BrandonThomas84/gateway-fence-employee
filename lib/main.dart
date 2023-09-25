// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:nested/nested.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/providers/auth_provider.dart';
import 'package:gateway_fence_employee/providers/current_route_provider.dart';
import 'package:gateway_fence_employee/providers/dev_provider.dart';
import 'package:gateway_fence_employee/providers/timer_provider.dart';
import 'package:gateway_fence_employee/screens/_router.dart';
import 'package:gateway_fence_employee/util/config.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: AppColors.black,
  ));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final FirebaseDatabase _ = FirebaseDatabase.instance;

  /// this is for local testing and the port should be updated if
  /// the port is changed in the firebase.json file
  await FirebaseAuth.instanceFor(
          app: Firebase.app(), persistence: Persistence.LOCAL)
      .useAuthEmulator('127.0.0.1', 9099);

  runApp(MultiProvider(providers: <SingleChildWidget>[
    // ignore: always_specify_types
    ChangeNotifierProvider(create: (BuildContext context) => AuthProvider()),
    // ignore: always_specify_types
    ChangeNotifierProvider(create: (BuildContext context) => CurrentRouteProvider()),
    // ignore: always_specify_types
    ChangeNotifierProvider(create: (BuildContext context) => Timer()),
    // ignore: always_specify_types
    ChangeNotifierProvider(create: (BuildContext context) => DevProvider()),
  ], child: const GatewayFenceEmployeeApp()));
}

class GatewayFenceEmployeeApp extends StatelessWidget {
  const GatewayFenceEmployeeApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // setup the authentication listeners so the provider can be automatically updated
    setupAuthStateChanges(context);

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
