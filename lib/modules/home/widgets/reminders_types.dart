import 'package:flutter/material.dart';
import 'reminders_list.dart';
import '../../../data/models/reminder_model.dart';
import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';

import '../../../app/config/constants.dart';

class ActivitiesTypes extends StatefulWidget {
  final Map<String, List<ReminderModel>> eventsPerType;
  final int initialTabIndex;
  const ActivitiesTypes({
    super.key,
    required this.eventsPerType,
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
    final List<String> eventsTabs = widget.eventsPerType.keys.toList();
    final int eventsQuantity =
        widget.eventsPerType.values.elementAt(_currentIndex).length;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: containerBg,
        borderRadius: BorderRadius.circular(15),
        boxShadow: shadows,
      ),
      child: Column(
        children: [
          Row(
            children: [
              ...List.generate(
                eventsTabs.length,
                (x) => Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: resp.hp(1.5)),
                      GestureDetector(
                        onTap: () {
                          if (_currentIndex != x) {
                            setState(() {
                              _currentIndex = x;
                            });
                          }
                        },
                        child: Text(
                          '${eventsTabs[x]} ${x == _currentIndex ? '($eventsQuantity)' : ''}',
                          style: x == _currentIndex
                              ? TextStyles.w700(16)
                              : TextStyles.w600(16, grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: resp.hp(0.5)),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        height: resp.hp(1),
                        decoration: BoxDecoration(
                          gradient: _currentIndex == x ? accentGradient : null,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          EventsListPerType(
            data: widget.eventsPerType.values.elementAt(_currentIndex),
            maxEventsToShow: 1,
          ),
        ],
      ),
    );
  }
}
