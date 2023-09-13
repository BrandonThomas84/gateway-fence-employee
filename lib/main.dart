import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/event_list/item.dart';
import 'package:gateway_fence_employee/sidebar/sidebar.dart';
import 'package:gateway_fence_employee/util/log.dart';

import 'event_list/list.dart';

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

  runApp(GatewayFenceEmployeeApp());
}

class GatewayFenceEmployeeApp extends StatelessWidget {
  GatewayFenceEmployeeApp({Key? key}) : super(key: key);

  final List<EventItem> eventList = [
    const EventItem(text: 'My Event 1', time: '12:34:45 PM'),
    const EventItem(text: 'My Event 2', time: '12:35:45 PM'),
    const EventItem(text: 'My Event 3', time: '12:36:45 PM'),
    const EventItem(text: 'My Event 4', time: '12:37:45 PM'),
    const EventItem(text: 'My Event 5', time: '12:38:45 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gateway Fence Employee App',
      theme: ThemeData(fontFamily: 'Poppins'),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: const Sidebar(),
        backgroundColor: AppColors.greyDark,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: EventList(eventList: eventList, date: DateTime.now()),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  color: AppColors.blueLight,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Tooltip(
                        message: 'Clock In',
                        child: ElevatedButton(
                          onPressed: () {
                            // Add your button press logic here
                            Logger.error("Clock in button pressed", data: {
                              'button': 'clock_in',
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            textStyle: const TextStyle(fontSize: 9),
                          ),
                          child: const Icon(Icons.more_time_outlined),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
