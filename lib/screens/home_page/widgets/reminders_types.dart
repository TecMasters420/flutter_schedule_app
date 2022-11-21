import 'package:flutter/material.dart';
import 'package:schedulemanager/models/reminder_model.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/utils/text_styles.dart';

import '../../../constants/constants.dart';

class ActivitiesTypes extends StatefulWidget {
  final Map<String, List<ReminderModel>> remindersPerType;
  final Widget Function(List<ReminderModel>) showDataChild;
  final int initialTabIndex;
  const ActivitiesTypes({
    super.key,
    required this.remindersPerType,
    required this.initialTabIndex,
    required this.showDataChild,
  });

  @override
  State<ActivitiesTypes> createState() => _ActivitiesTypesState();
}

class _ActivitiesTypesState extends State<ActivitiesTypes> {
  late int _currentIndex;
  @override
  void initState() {
    super.initState();
    debugPrint(
        'Debug ${widget.remindersPerType.values.map((e) => debugPrint(e.length.toString()))}');
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
        widget.showDataChild(
            widget.remindersPerType.values.elementAt(_currentIndex))
      ],
    );
  }
}
