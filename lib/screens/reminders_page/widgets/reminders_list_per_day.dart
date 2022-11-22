import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import '../../../models/reminder_model.dart';
import '../../../utils/responsive_util.dart';

import '../../../constants/constants.dart';
import '../../../widgets/reminder_container.dart';
import '../../../widgets/reminder_information.dart';
import 'reminder_hour.dart';

class RemindersListPerDay extends StatefulWidget {
  final List<ReminderModel> reminders;
  const RemindersListPerDay({
    super.key,
    required this.reminders,
  });

  @override
  State<RemindersListPerDay> createState() => _RemindersListPerDayState();
}

class _RemindersListPerDayState extends State<RemindersListPerDay> {
  late bool _containersHeightIsGen;
  late List<GlobalKey> _keys;
  late List<int> _colorsIndexs;
  late List<Size?> _sizes;

  @override
  void initState() {
    super.initState();
    _clearKeyAndSize(widget.reminders.length);
  }

  void _clearKeyAndSize(final int quantity) {
    _containersHeightIsGen = false;
    _sizes = List.generate(quantity, (index) => null);
    _colorsIndexs =
        List.generate(quantity, (index) => Random().nextInt(colors.length - 1));
    _keys = List.generate(quantity, (index) => GlobalKey());
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    SchedulerBinding.instance.addPostFrameCallback((_) async {
      if (_containersHeightIsGen) return;
      for (int x = 0; x < _keys.length; x++) {
        final RenderObject? renderBoxRed =
            _keys[x].currentContext?.findRenderObject();
        final sizeRed = renderBoxRed!.paintBounds;
        _sizes[x] = sizeRed.size;
      }
      setState(() {
        _containersHeightIsGen = true;
      });
    });

    return Column(
      children: List.generate(
        widget.reminders.length,
        (x) {
          return ReminderContainer(
            containerKey: _keys[x],
            index: x,
            leftWidget: ReminderHour(
              hours: const ['09:00', '09:30'],
              fontSize: resp.sp14,
            ),
            middleWidget: AnimatedContainer(
              curve: Curves.easeIn,
              duration: const Duration(milliseconds: 300),
              height: _sizes[x] == null ? 0 : _sizes[x]!.height,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colors[_colorsIndexs[x]],
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            rightWidget: ReminderInformation(
              reminder: widget.reminders[x],
            ),
          );
        },
      ),
    );
  }
}
