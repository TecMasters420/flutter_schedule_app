import 'package:flutter/material.dart';
import 'package:schedulemanager/constants/constants.dart';
import 'package:schedulemanager/screens/reminder_details_page/widgets/create_reminder_form.dart';
import 'package:schedulemanager/services/base_service.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/utils/text_styles.dart';

import '../../../models/reminder_model.dart';

class ExpandibleCreationOrEditReminder extends StatefulWidget {
  final void Function(ReminderModel reminder) onAcceptCallback;
  final IconData icon;
  final double finalHeight;
  final double finalWidth;
  final double initialHeight;
  final double initialWidth;
  final double iconSize;
  final ReminderModel? reminder;

  const ExpandibleCreationOrEditReminder({
    super.key,
    required this.finalHeight,
    required this.finalWidth,
    required this.initialHeight,
    required this.initialWidth,
    required this.iconSize,
    required this.onAcceptCallback,
    required this.icon,
    this.reminder,
  });

  @override
  State<ExpandibleCreationOrEditReminder> createState() =>
      _ExpandibleCreationOrEditReminderState();
}

class _ExpandibleCreationOrEditReminderState
    extends State<ExpandibleCreationOrEditReminder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;
  late final ReminderModel _reminder;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 180));
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
      ..addListener(_animListener);

    _reminder = widget.reminder ??
        ReminderModel(
          creationDate: Timestamp.now(),
          description: '',
          address: '',
          endDate: Timestamp.now(),
          endLocation: null,
          expectedTemp: null,
          startDate: Timestamp.now(),
          startLocation: null,
          tags: [],
          tasks: [],
          title: '',
          id: null,
          uid: '',
        );
  }

  void _animListener() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double animValue = _animation.value;
    final double bodyValue = animValue;
    final double iconValue = 1 - animValue;
    final double containerWidth = (widget.finalWidth * animValue)
        .clamp(widget.initialWidth, widget.finalWidth);
    final double containerHeight = (widget.finalHeight * animValue)
        .clamp(widget.initialHeight, widget.finalHeight);

    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return GestureDetector(
      onTap: () => _controller.forward(),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: containerHeight,
        width: containerWidth,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 40,
              offset: const Offset(0, 20),
            )
          ],
        ),
        child: Padding(
          padding: animValue > 0
              ? const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                )
              : EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconValue != 0)
                Flexible(
                  child: Transform.scale(
                    scale: iconValue,
                    child: Icon(
                      widget.icon,
                      size: widget.iconSize,
                      color: black.withOpacity(iconValue),
                    ),
                  ),
                ),
              if (bodyValue != 0)
                Expanded(
                  child: Opacity(
                    opacity: bodyValue,
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: Text(
                                  'Create a new reminder',
                                  style: TextStyles.w700(resp.sp16),
                                ),
                              ),
                              Flexible(
                                child: IconButton(
                                  icon: const Icon(
                                      Icons.transit_enterexit_rounded),
                                  color: lightGrey,
                                  onPressed: () {
                                    _controller.reverse();
                                  },
                                ),
                              ),
                            ],
                          ),
                          CreateReminderForm(
                            reminder: _reminder,
                            onAcceptCallback: (reminder) {
                              _controller.reverse();
                              widget.onAcceptCallback(reminder);
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
