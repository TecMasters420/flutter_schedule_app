import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../app/config/constants.dart';
import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';
import 'date_container.dart';

class ScrolleableCalendar extends StatefulWidget {
  final List<int> days;
  final List<int> months;
  final int initialDay;
  final int initialMonth;
  final void Function(int selectedDay) onSelectedNewDay;
  final void Function(int selectedMonth) onSelectedNewMonth;
  final bool? showTitle;

  const ScrolleableCalendar({
    super.key,
    required this.days,
    required this.months,
    required this.initialDay,
    required this.onSelectedNewDay,
    required this.initialMonth,
    required this.onSelectedNewMonth,
    this.showTitle = true,
  });

  @override
  State<ScrolleableCalendar> createState() => _ScrolleableCalendarState();
}

class _ScrolleableCalendarState extends State<ScrolleableCalendar> {
  late int? _selectedDay;
  late int? _selectedMonth;
  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDay;
    _selectedMonth = widget.initialMonth;
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    if (!widget.days.contains(_selectedDay)) {
      _selectedDay = widget.days.isEmpty ? 0 : widget.days[0];
    }

    if (!widget.months.contains(_selectedMonth)) {
      _selectedMonth = widget.months.isEmpty ? 0 : widget.months[0];
    }

    final currentDayIndex = widget.days.indexOf(_selectedDay!);
    final currentMonthIndex = (_selectedMonth ?? widget.initialMonth) - 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.showTitle!) ...[
          Text('Select a date:', style: TextStyles.w700(resp.sp20)),
          SizedBox(height: resp.hp(2)),
        ],
        // Text('Year:', style: TextStyles.w700(16)),
        // SizedBox(height: resp.hp(1)),
        // CustomDateContainer(
        //   data: List.generate(3, (index) => DateTime.now().year + index),
        //   initialElementIndex: 0,
        //   onPressElement: (pressedElementIndex, index) {},
        //   widgetBuild: (currentElement, isSelected, index) {
        //     return Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: [
        //         Text(
        //           currentElement.toString(),
        //           style: TextStyles.w500(
        //             16,
        //             isSelected ? black : lightGrey,
        //           ),
        //         ),
        //         SizedBox(height: resp.hp(0.5)),
        //         AnimatedContainer(
        //           duration: const Duration(milliseconds: 250),
        //           height: resp.hp(0.75),
        //           width: isSelected ? resp.wp(5) : resp.wp(2.5),
        //           decoration: BoxDecoration(
        //             color: isSelected ? accent : lightGrey.withOpacity(0.25),
        //             borderRadius: const BorderRadius.all(
        //               Radius.circular(10),
        //             ),
        //           ),
        //         )
        //       ],
        //     );
        //   },
        // ),
        SizedBox(height: resp.hp(2)),
        Text('Month:', style: TextStyles.w700(16)),
        SizedBox(height: resp.hp(1)),
        CustomDateContainer(
          data: List.generate(12, (index) => index + 1),
          initialElementIndex: currentMonthIndex < 0 ? 0 : currentMonthIndex,
          selectableValues: widget.months,
          onPressElement: (itemPressed, index) {
            debugPrint('MONTH pressed: $itemPressed $index');
            final int month = itemPressed;
            setState(() {
              _selectedMonth = month;
              widget.onSelectedNewMonth(month);
            });
          },
          widgetBuild: (currentElement, isSelected, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('MMMM').format(DateTime(
                    DateTime.now().year,
                    currentElement,
                  )),
                  style: TextStyles.w500(
                    16,
                    isSelected ? black : lightGrey,
                  ),
                ),
                SizedBox(height: resp.hp(0.5)),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: resp.hp(0.75),
                  width: isSelected ? resp.wp(5) : resp.wp(2.5),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? accent
                        : widget.months.contains(currentElement)
                            ? lightGrey.withOpacity(0.25)
                            : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                )
              ],
            );
          },
        ),
        SizedBox(height: resp.hp(1)),
        Text('Day:', style: TextStyles.w700(16)),
        SizedBox(height: resp.hp(1)),
        // ? DAYS LIST
        CustomDateContainer(
          data: widget.days,
          selectableValues: widget.days,
          initialElementIndex: currentDayIndex < 0 ? 0 : currentDayIndex,
          onPressElement: (itemPressed, index) {
            setState(() {
              _selectedDay = itemPressed;
              widget.onSelectedNewDay(itemPressed);
            });
          },
          widgetBuild: (currentElement, isSelected, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? accent : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      widget.days[index].toString().length == 1
                          ? ' ${widget.days[index]} '
                          : widget.days[index].toString(),
                      style: TextStyles.w500(
                          16, isSelected ? Colors.white : lightGrey),
                    ),
                  ),
                ),
                Text(
                  DateFormat('EEEE')
                      .format(DateTime(
                          DateTime.now().year, _selectedMonth!, currentElement))
                      .substring(0, 3)
                      .toUpperCase(),
                  style: TextStyles.w500(
                    16,
                    isSelected ? black : lightGrey,
                  ),
                ),
                SizedBox(height: resp.hp(0.5)),
                Container(
                  height: resp.hp(0.75),
                  width: resp.wp(5),
                  decoration: BoxDecoration(
                    color: isSelected ? accent : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ],
    );
  }
}
