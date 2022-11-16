import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/constants/constants.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/utils/text_styles.dart';
import 'package:schedulemanager/widgets/custom_form_field.dart';

class ExpandibleBottomContainer extends StatefulWidget {
  final double finalHeight;
  final double finalWidth;
  final double initialHeight;
  final double initialWidth;
  final double iconSize;
  const ExpandibleBottomContainer({
    super.key,
    required this.finalHeight,
    required this.finalWidth,
    required this.initialHeight,
    required this.initialWidth,
    required this.iconSize,
  });

  @override
  State<ExpandibleBottomContainer> createState() =>
      _ExpandibleBottomContainerState();
}

class _ExpandibleBottomContainerState extends State<ExpandibleBottomContainer> {
  static const double _transitionPercent = 50; // % percent
  static const List<String> _types = [
    'Project',
    'Meeting',
    'Shot Dribbble',
    'Standup',
    'Sprint'
  ];

  late final Map<String, Color?> _coloredTypes;

  late double _currentHeight;
  late double _currentWidth;
  late double _iconTransitionValue;
  late double _bodyTransitionValue;
  late double _containerTransitionValue;

  @override
  void initState() {
    super.initState();
    _containerTransitionValue = 0;
    _iconTransitionValue = 0;
    _bodyTransitionValue = 0;
    _currentHeight = widget.initialHeight;
    _currentWidth = widget.initialWidth;

    _coloredTypes = {};
    for (final String type in _types) {
      _coloredTypes.addAll({type: colors[Random().nextInt(colors.length - 1)]});
    }
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final bool isInBodyTransition =
        _bodyTransitionValue != 0 && _iconTransitionValue == 1;
    return GestureDetector(
      onVerticalDragUpdate: (details) {
        final increment = -1 * details.delta.dy;
        setState(() {
          _currentHeight += increment;
          _currentHeight = clampDouble(
              _currentHeight, widget.initialHeight, widget.finalHeight);

          _containerTransitionValue = _currentHeight / widget.finalHeight;

          final double maxHeightPerPercent =
              widget.finalHeight * (_transitionPercent / 100);

          _iconTransitionValue =
              (_currentHeight / maxHeightPerPercent).clamp(0, 1);

          if (_currentHeight >= maxHeightPerPercent) {
            _bodyTransitionValue = _containerTransitionValue -
                (_iconTransitionValue - _containerTransitionValue);
          }

          final double heightInitialPercent =
              widget.initialHeight / widget.finalHeight;
          final double width = widget.initialWidth +
              (widget.finalWidth *
                  (_containerTransitionValue - heightInitialPercent));
          _currentWidth = width;
        });
      },
      onVerticalDragEnd: (details) {
        if (_currentHeight >= (widget.finalHeight / 2)) {
          setState(() {
            _currentHeight = widget.finalHeight;
            _currentWidth = widget.finalWidth;
          });
        } else {
          setState(() {
            _currentHeight = widget.initialHeight;
            _currentWidth = widget.initialWidth;
          });
        }
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.decelerate,
        height: _currentHeight,
        width: _currentWidth,
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
          padding: isInBodyTransition
              ? const EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20,
                )
              : EdgeInsets.zero,
          child: Stack(
            alignment: _bodyTransitionValue != 0 && _iconTransitionValue == 1
                ? Alignment.topLeft
                : Alignment.center,
            children: [
              Icon(
                Icons.add,
                size: widget.iconSize,
                color: black.withOpacity(_iconTransitionValue >= 0.20
                    ? 1 - _iconTransitionValue
                    : 1),
              ),
              FittedBox(
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Opacity(
                    opacity: _bodyTransitionValue,
                    child: SizedBox(
                      width: _currentWidth - 40,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Stack(
                            fit: StackFit.loose,
                            children: [
                              Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Create a new reminder',
                                  style: TextStyles.w700(resp.dp(1.5)),
                                ),
                              ),
                              const Align(
                                alignment: Alignment.topRight,
                                child: Icon(
                                  Icons.transit_enterexit_rounded,
                                  color: lightGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: resp.hp(1.5)),
                          Text(
                            'Title',
                            style: TextStyles.w600(resp.dp(1.25)),
                          ),
                          SizedBox(height: resp.hp(1.5)),
                          CustomFormField(
                            labelText: 'Title',
                            hintText: 'my title',
                            icon: Icons.my_library_books_outlined,
                            onChanged: (value) {},
                          ),
                          SizedBox(height: resp.hp(1.5)),
                          Text(
                            'Description',
                            style: TextStyles.w600(resp.dp(1.25)),
                          ),
                          SizedBox(height: resp.hp(1.5)),
                          CustomFormField(
                            labelText: 'Description',
                            hintText: 'My description',
                            icon: Icons.mode_edit_outline_outlined,
                            onChanged: (value) {},
                          ),
                          SizedBox(height: resp.hp(1.5)),
                          Text(
                            'Tag',
                            style: TextStyles.w600(resp.dp(1.25)),
                          ),
                          SizedBox(height: resp.hp(1.5)),
                          Wrap(
                            children: List.generate(
                              _coloredTypes.length,
                              (index) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5,
                                  horizontal: 3,
                                ),
                                child: Chip(
                                  // backgroundColor:
                                  //     _coloredTypes.values.elementAt(index),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  label: Text(
                                    _coloredTypes.keys.elementAt(index),
                                    style: TextStyles.w500(
                                      resp.dp(1),
                                      // Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: resp.hp(1.5)),
                          Text(
                            'Date',
                            style: TextStyles.w600(resp.dp(1.25)),
                          ),
                          SizedBox(height: resp.hp(1.5)),
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month_outlined,
                                color: lightGrey,
                              ),
                              SizedBox(width: resp.wp(1)),
                              Text(
                                DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US')
                                    .format(
                                  DateTime.now().toUtc(),
                                ),
                                style: TextStyles.w300(
                                  resp.dp(1.25),
                                  lightGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: resp.hp(1.5)),
                          Text(
                            'Duration',
                            style: TextStyles.w600(resp.dp(1.25)),
                          ),
                          SizedBox(height: resp.hp(1.5)),
                          Row(
                            children: [
                              const Icon(
                                Icons.watch_later_outlined,
                                color: lightGrey,
                              ),
                              SizedBox(width: resp.wp(1)),
                              Text(
                                '10:00 - 11:00',
                                style: TextStyles.w300(
                                  resp.dp(1.25),
                                  lightGrey,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: resp.hp(1.5)),
                          Text(
                            'Location',
                            style: TextStyles.w600(resp.dp(1.25)),
                          ),
                          SizedBox(height: resp.hp(1.5)),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                color: lightGrey,
                              ),
                              SizedBox(width: resp.wp(1)),
                              Text(
                                'Tijuana, BC',
                                style: TextStyles.w300(
                                  resp.dp(1.25),
                                  lightGrey,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
