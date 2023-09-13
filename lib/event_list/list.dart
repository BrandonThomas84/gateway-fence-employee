import 'package:flutter/material.dart';

import 'item.dart';
import 'section.dart';

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
    return Column(
      children: [
        EventListSection(title: _dateTitle, events: eventList),
        EventListSection(title: 'Yesterday', events: eventList),
        EventListSection(title: 'September, 11th 2023', events: eventList),
        EventListSection(title: 'September, 10th 2023', events: eventList),
        EventListSection(title: 'September, 9th 2023', events: eventList)
      ],
    );
  }
}
