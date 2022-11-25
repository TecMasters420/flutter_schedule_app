import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants/constants.dart';
import '../../../utils/responsive_util.dart';
import '../../../utils/text_styles.dart';
import '../../reminders_page/widgets/date_container.dart';

class ScrolleableCalendarWithHour extends StatefulWidget {
  final DateTime firstDate;
  final DateTime endDate;

  final void Function(DateTime date) onChangesInDate;

  const ScrolleableCalendarWithHour({
    super.key,
    required this.firstDate,
    required this.endDate,
    required this.onChangesInDate,
  });

  @override
  State<ScrolleableCalendarWithHour> createState() =>
      _ScrolleableCalendarWithHourState();
}

class _ScrolleableCalendarWithHourState
    extends State<ScrolleableCalendarWithHour> {
  late int _startMonth;
  late List<int> _monthsToShow;
  late List<int> _daysToShow;
  late int _selectedMonth;
  late int _selectedDay;
  late int _selectedHour;
  late int _selectedMinute;

  @override
  void initState() {
    super.initState();
    _startMonth = widget.firstDate.month;
    _monthsToShow =
        List.generate(12 - (_startMonth - 1), (index) => _startMonth + index);
    _selectedMonth = _startMonth;
    _selectedDay = widget.firstDate.day;
    _selectedHour = widget.firstDate.hour;
    _selectedMinute = widget.firstDate.minute;
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    if (_selectedMonth == _startMonth && _selectedDay < widget.firstDate.day) {
      _selectedDay = widget.firstDate.day;
    }
    if (_selectedMonth == _startMonth &&
        _selectedDay == widget.firstDate.day &&
        _selectedHour < widget.firstDate.hour) {
      _selectedHour = widget.firstDate.hour;
    }
    if (_selectedMonth == _startMonth &&
        _selectedDay == widget.firstDate.day &&
        _selectedHour < widget.firstDate.hour &&
        _selectedMinute < widget.firstDate.minute) {
      _selectedMinute = widget.firstDate.minute;
    }

    final now = DateTime(DateTime.now().year, _selectedMonth);
    final daysInMonth =
        DateTime(now.year, now.month + 1).toUtc().difference(now).inDays;

    final int adjust = _selectedMonth == _startMonth ? widget.firstDate.day : 1;

    final int hourAdjust =
        _startMonth == _selectedMonth && _selectedDay == widget.firstDate.day
            ? widget.firstDate.hour
            : 0;
    final List<int> hoursToShow =
        List.generate(24 - hourAdjust, (index) => hourAdjust + index);

    _daysToShow =
        List.generate((daysInMonth + 1) - adjust, (index) => index + adjust);

    final int minuteAdjust = _startMonth == _selectedMonth &&
            _selectedDay == widget.firstDate.day &&
            _selectedHour == widget.firstDate.hour
        ? widget.firstDate.minute
        : 0;
    final List<int> minutesToShow =
        List.generate(60 - minuteAdjust, (index) => minuteAdjust + index);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: resp.hp(2)),
        Text('Month:', style: TextStyles.w700(resp.sp16)),
        SizedBox(height: resp.hp(1)),
        CustomDateContainer(
          data: _monthsToShow,
          initialElementIndex: _monthsToShow.indexOf(_selectedMonth),
          selectableValues: _monthsToShow,
          onPressElement: (itemPressed, index) {
            debugPrint('MONTH pressed: $itemPressed $index');
            setState(() {
              _selectedMonth = itemPressed;
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
                    resp.sp16,
                    isSelected ? black : lightGrey,
                  ),
                ),
                SizedBox(height: resp.hp(0.5)),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: resp.hp(0.75),
                  width: isSelected ? resp.wp(5) : resp.wp(2.5),
                  decoration: BoxDecoration(
                    color: isSelected ? accent : lightGrey.withOpacity(0.25),
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
        Text('Day:', style: TextStyles.w700(resp.sp16)),
        SizedBox(height: resp.hp(1)),
        // ? DAYS LIST
        CustomDateContainer(
          data: _daysToShow,
          selectableValues: _daysToShow,
          initialElementIndex: _daysToShow.indexOf(_selectedDay),
          onPressElement: (itemPressed, index) {
            setState(() {
              _selectedDay = itemPressed;
              widget.onChangesInDate(DateTime(
                  DateTime.now().year,
                  _selectedMonth,
                  _selectedDay,
                  _selectedHour,
                  _selectedMinute));
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
                      currentElement.toString(),
                      style: TextStyles.w500(
                          resp.sp16, isSelected ? Colors.white : lightGrey),
                    ),
                  ),
                ),
                Text(
                  DateFormat('EEEE')
                      .format(DateTime(
                          DateTime.now().year, _selectedMonth, currentElement))
                      .substring(0, 3)
                      .toUpperCase(),
                  style: TextStyles.w500(
                    resp.sp16,
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
        SizedBox(height: resp.hp(1)),
        Text('Hour:', style: TextStyles.w700(resp.sp16)),
        SizedBox(height: resp.hp(1)),
        // ? HOURS LIST
        CustomDateContainer(
          data: hoursToShow,
          selectableValues: hoursToShow,
          initialElementIndex: hoursToShow.indexOf(_selectedHour),
          onPressElement: (itemPressed, index) {
            setState(() {
              _selectedHour = itemPressed;
              widget.onChangesInDate(DateTime(
                  DateTime.now().year,
                  _selectedMonth,
                  _selectedDay,
                  _selectedHour,
                  _selectedMinute));
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
                      (currentElement > 12
                              ? currentElement - 11
                              : currentElement)
                          .toString(),
                      style: TextStyles.w500(
                          resp.sp16, isSelected ? Colors.white : lightGrey),
                    ),
                  ),
                ),
                Text(
                  currentElement >= 12 ? 'PM' : 'AM',
                  style: TextStyles.w500(
                    resp.sp16,
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
        SizedBox(height: resp.hp(1)),
        Text('Minutes:', style: TextStyles.w700(resp.sp16)),
        SizedBox(height: resp.hp(1)),
        // ? MINUTES LIST
        CustomDateContainer(
          data: minutesToShow,
          selectableValues: minutesToShow,
          initialElementIndex: minutesToShow
              .indexOf(_selectedMinute)
              .clamp(0, minutesToShow.length),
          onPressElement: (itemPressed, index) {
            setState(() {
              _selectedMinute = itemPressed;
              widget.onChangesInDate(DateTime(
                  DateTime.now().year,
                  _selectedMonth,
                  _selectedDay,
                  _selectedHour,
                  _selectedMinute));
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
                      currentElement.toString(),
                      style: TextStyles.w500(
                          resp.sp16, isSelected ? Colors.white : lightGrey),
                    ),
                  ),
                ),
                Text(
                  'MIN',
                  style: TextStyles.w500(
                    resp.sp16,
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
