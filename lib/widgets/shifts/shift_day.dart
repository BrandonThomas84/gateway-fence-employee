// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:gateway_fence_employee/config/colors.dart';
import 'package:gateway_fence_employee/models/shift.dart';
import 'package:gateway_fence_employee/util/log.dart';
import 'package:gateway_fence_employee/util/time.dart';
import 'shift_day_subtitle.dart';
import 'shift_day_title.dart';

class ShiftDay extends StatefulWidget {
  const ShiftDay({
    super.key,
    required this.date,
    required this.shifts,
    this.startExpanded = false,
  });

  // The date that will be used to construct the title
  final DateTime date;

  /// the list of events that will be displayed
  final List<Shift> shifts;

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
  late String _title = '';
  late String _subTitle = '';
  late Duration _totalDuration = const Duration();
  late final List<Container> _shifts = <Container>[];

  @override
  void initState() {
    super.initState();
    AppLogger.trace('shift day init state is running');

    _buildShifts();

    _title = prettyDate(widget.date, false);
    _subTitle = getDurationString(_totalDuration);
  }

  /// Build the list of shifts
  void _buildShifts() {
    for (Shift shift in widget.shifts) {
      _totalDuration += shift.getDuration();
      _shifts.add(
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 15,
          ),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Start:'),
                  Text(shift.getStartTimeString()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('End:'),
                  Text(shift.getEndTimeString()),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text('Duration:'),
                  Text(getDurationString(shift.getDuration())),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      color: AppColors.white,
      child: ExpansionTile(
        shape: const Border(), // remove the border
        initiallyExpanded: widget.startExpanded,
        onExpansionChanged: (bool isExpanded) {
          setState(() {
            _isExpanded = isExpanded;
          });
        },
        iconColor: _isExpanded ? AppColors.blue : AppColors.greyDark,
        title: ShiftDayTitle(
          title: _title,
          allowEdit: false,
        ),
        subtitle: ShiftDaySubitle(_subTitle),
        children: <Widget>[
          for (Shift shift in widget.shifts) ...<Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Clock In:'),
                      Text(shift.getStartTimeString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Clock Out:'),
                      Text(shift.getEndTimeString()),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Total Hours:'),
                      Text(getDurationString(shift.getDuration())),
                    ],
                  ),
                ],
              ),
            )
          ],
        ],
      ),
    );
  }
}
