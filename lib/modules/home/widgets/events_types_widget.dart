import 'package:flutter/material.dart';
import 'package:schedulemanager/modules/home/models/events_type_model.dart';
import 'package:schedulemanager/widgets/loading_widget.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';
import 'events_list_per_type_widget.dart';
import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';

import '../../../app/config/constants.dart';

class EventsTypesWidget extends StatefulWidget {
  final int initialTabIndex;
  final bool isLoading;
  final VoidCallback onTapNew;
  final List<EventsTypeModel> events;
  const EventsTypesWidget({
    super.key,
    required this.initialTabIndex,
    required this.isLoading,
    required this.onTapNew,
    required this.events,
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
    final styles = TextStyles.of(context);
    final List<String> eventsTabs = widget.events.map((e) => e.label).toList();
    final int eventsQuantity = widget.events[_currentIndex].events.length;

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
                              ? styles.w700(16)
                              : styles.w600(16, grey),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: resp.hp(0.5)),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 100),
                        height: resp.hp(1),
                        decoration: BoxDecoration(
                          color: _currentIndex == x
                              ? widget.events[_currentIndex].color
                              : null,
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
                    eventsType: widget.events[_currentIndex],
                    key: Key(false.toString()),
                    maxEventsToShow: 2,
                  ),
          )
        ],
      ),
    );
  }
}
