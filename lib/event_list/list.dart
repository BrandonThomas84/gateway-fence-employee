import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';

import 'item.dart';
import 'section_title.dart';

class EventList extends StatelessWidget {
  const EventList({
    super.key,
    required this.eventList,
    required this.date,
  });

  /// the list of events that will be displayed
  final List<EventItem> eventList;

  /// The original date that will be converted to a local string and displayed
  /// as the collapsable header
  final DateTime date;

  /// The date that will be displayed as the section header
  final String _dateTitle = 'Today';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: AppColors.white,
      child: ExpansionTile(
        title: EventSectionTitle(
          title: _dateTitle,
          allowEdit: false,
        ),
        children: [
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(),
            itemCount: eventList.length,
            itemBuilder: (context, index) {
              return eventList[index];
            },
          ),
        ],
      ),
    );
  }
}
