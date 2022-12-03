import 'package:flutter/material.dart';
import 'reminders_list.dart';
import '../../../../data/models/reminder_model.dart';
import '../../../../app/utils/responsive_util.dart';
import '../../../../app/utils/text_styles.dart';

import '../../../../app/config/constants.dart';

class ActivitiesTypes extends StatefulWidget {
  final Map<String, List<ReminderModel>> remindersPerType;
  final int initialTabIndex;
  const ActivitiesTypes({
    super.key,
    required this.remindersPerType,
    required this.initialTabIndex,
  });

  @override
  State<ActivitiesTypes> createState() => _ActivitiesTypesState();
}

class _ActivitiesTypesState extends State<ActivitiesTypes> {
  late int _currentIndex;
  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialTabIndex;
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final List<String> remindersTabs = widget.remindersPerType.keys.toList();

    return Column(
      children: [
        Row(
          children: [
            ...List.generate(
              remindersTabs.length,
              (x) => Expanded(
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (_currentIndex != x) {
                          setState(() {
                            _currentIndex = x;
                          });
                        }
                      },
                      child: Text(
                        remindersTabs[x],
                        style: x == _currentIndex
                            ? TextStyles.w700(resp.sp16)
                            : TextStyles.w600(resp.sp16, grey),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: resp.hp(1)),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      height: resp.hp(1),
                      decoration: BoxDecoration(
                        color: _currentIndex == x ? accent : Colors.transparent,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        RemindersListPerType(
          data: widget.remindersPerType.values.elementAt(_currentIndex),
          maxRemindersToShow: 1,
        ),
      ],
    );
  }
}
