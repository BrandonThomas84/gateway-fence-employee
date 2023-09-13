import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/appbar/custom_app_bar.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/event_list/item.dart';
import 'package:gateway_fence_employee/event_list/list.dart';
import 'package:gateway_fence_employee/sidebar/sidebar.dart';

class HomeRoute extends StatelessWidget {
  HomeRoute({
    super.key,
  });

  final List<EventItem> eventList = [
    const EventItem(text: 'My Event 1', time: '12:34:45 PM'),
    const EventItem(text: 'My Event 2', time: '12:35:45 PM'),
    const EventItem(text: 'My Event 3', time: '12:36:45 PM'),
    const EventItem(text: 'My Event 4', time: '12:37:45 PM'),
    const EventItem(text: 'My Event 5', time: '12:38:45 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const Sidebar(),
      backgroundColor: AppColors.greyDark,
      bottomNavigationBar: const CustomAppBar(routeOwner: RouteOwner.home),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: EventList(eventList: eventList, date: DateTime.now()),
            ),
          ],
        ),
      ),
    );
  }
}
