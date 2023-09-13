
import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';

import 'item.dart';
import 'section_title.dart';

class EventListSection extends StatelessWidget {
  const EventListSection({
    super.key,
    required this.title,
    required this.events,
  });

  final String title;
  final List<EventItem> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: AppColors.white,
      child: ExpansionTile(
        title: EventListSectionTitle(
          title: title,
          allowEdit: false,
        ),
        children: [
          ListView.separated(
            shrinkWrap: true,
            separatorBuilder: (context, index) => const Divider(),
            itemCount: events.length,
            itemBuilder: (context, index) {
              return events[index];
            },
          ),
        ],
      ),
    );
  }
}
