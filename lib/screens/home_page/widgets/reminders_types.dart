import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:schedulemanager/providers/activities_provider.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/utils/text_styles.dart';

import '../../../constants/constants.dart';

class ActivitiesTypes extends StatefulWidget {
  static const List<String> _types = ['Next', 'Not completed', 'Canceled'];
  const ActivitiesTypes({
    super.key,
  });

  @override
  State<ActivitiesTypes> createState() => _ActivitiesTypesState();
}

class _ActivitiesTypesState extends State<ActivitiesTypes> {
  late Map<String, int> _typesWithReminders;

  @override
  void initState() {
    super.initState();
    _initTypesWithReminders();
  }

  void _initTypesWithReminders() {
    _typesWithReminders = {};
    for (final String type in ActivitiesTypes._types) {
      _typesWithReminders.addAll({type: Random().nextInt(10)});
    }
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ActivitiesProvider>(context, listen: false)
          .newActivitieTypeSelected(0, _typesWithReminders.values.elementAt(0));
    });
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final ActivitiesProvider activities =
        Provider.of<ActivitiesProvider>(context);
    return Row(
      children: [
        ...List.generate(
          _typesWithReminders.length,
          (x) => Expanded(
            child: GestureDetector(
              onTap: () {
                if (activities.selectedTypeIndex != x) {
                  activities.newActivitieTypeSelected(
                      x, _typesWithReminders.values.elementAt(x));
                }
              },
              child: Container(
                alignment: Alignment.center,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 100),
                  transitionBuilder: (child, animation) {
                    return FadeTransition(
                      opacity: animation,
                      // scale: animation,
                      child: child,
                    );
                  },
                  child: Text(
                    key: Key('${x == activities.selectedTypeIndex}'),
                    _typesWithReminders.keys.elementAt(x),
                    style: x == activities.selectedTypeIndex
                        ? TextStyles.w700(resp.sp16)
                        : TextStyles.w600(resp.sp16, grey),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
