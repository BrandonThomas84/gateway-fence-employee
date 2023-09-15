import 'package:flutter/material.dart';
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/util/time.dart';

import 'shift.dart';
import 'shift_day_subtitle.dart';
import 'shift_day_title.dart';

class ShiftDay extends StatefulWidget {
  const ShiftDay({
    super.key,
    required this.date,
    required this.events,
    this.subTitle,
    this.startExpanded = false,
  });

  // The date that will be used to construct the title
  final DateTime date;

  /// Optional subtitle to be displayed on the collapsable header
  final String? subTitle;

  /// the list of events that will be displayed
  final List<Shift> events;

  /// Whether or not the section will begin expanded.
  /// This is useful on the current day or after search
  final bool startExpanded;

  @override
  State<ShiftDay> createState() => _ShiftDayState();
}

/// The state of the ShiftDay widget
class _ShiftDayState extends State<ShiftDay> {
  /// whether or not the section is expanded
  bool _isExpanded = false;

  /// default title to blank string until it is set in the initState
  String? _title;

  @override
  void initState() {
    super.initState();
    _title = getDateTimeAsString(widget.date, false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: AppColors.white,
      child: ExpansionTile(
        shape: const Border(), // remove the border
        initiallyExpanded: widget.startExpanded,
        onExpansionChanged: (isExpanded) {
          setState(() {
            _isExpanded = isExpanded;
          });
        },
        iconColor: _isExpanded ? AppColors.blue : AppColors.greyDark,
        title: ShiftDayTitle(
          title: _title!,
          allowEdit: false,
        ),
        subtitle:
            widget.subTitle != null ? ShiftDaySubitle(widget.subTitle!) : null,
        children: [
          ListView.builder(
            shrinkWrap: true,
            // separatorBuilder: (context, index) => const Divider(),
            itemCount: widget.events.length,
            itemBuilder: (context, index) {
              return widget.events[index];
            },
          ),
        ],
      ),
    );
  }
}
