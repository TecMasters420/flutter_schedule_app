import 'package:flutter/material.dart';
import 'package:schedulemanager/widgets/loading_widget.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';
import 'events_list_per_type_widget.dart';
import '../../../data/models/reminder_model.dart';
import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';

import '../../../app/config/constants.dart';

class EventsTypesWidget extends StatefulWidget {
  final Map<String, List<EventModel>> eventsPerType;
  final int initialTabIndex;
  final bool isLoading;
  final VoidCallback onTapNew;
  const EventsTypesWidget({
    super.key,
    required this.eventsPerType,
    required this.initialTabIndex,
    required this.isLoading,
    required this.onTapNew,
  });

  @override
  State<EventsTypesWidget> createState() => _EventsTypesWidgetState();
}

class _EventsTypesWidgetState extends State<EventsTypesWidget> {
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

    return ResponsiveContainerWidget(
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
                          widget.onTapNew();
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
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: widget.isLoading
                ? SizedBox(
                    height: resp.hp(31),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingWidget(key: Key(true.toString())),
                      ],
                    ),
                  )
                : EventsListPerType(
                    key: Key(false.toString()),
                    data: widget.eventsPerType.values.elementAt(_currentIndex),
                    maxEventsToShow: 2,
                    type: eventsTabs[_currentIndex],
                  ),
          )
        ],
      ),
    );
  }
}
