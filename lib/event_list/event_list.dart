import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';

import 'item.dart';
import 'section_title.dart';

class EventList extends StatelessWidget {
  const EventList({
    super.key,
    required this.eventList,
  });

  final List<EventItem> eventList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: AppColors.white,
      child: ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (context, index) => const Divider(),
        itemCount: eventList.length + 1,
        itemBuilder: (context, index) {
          if (index == 0) {
            return const Column(
              children: [
                EventSectionTitle(
                  date: 'Today',
                  allowEdit: false,
                ),
                EventSectionTitle(
                  date: 'Yesterday',
                  allowEdit: true,
                ),
              ],
            );
          }

          return eventList[index - 1];
        },
      ),
    );
  }
}
