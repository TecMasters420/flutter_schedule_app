import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants/constants.dart';
import '../../../utils/responsive_util.dart';
import '../../../utils/text_styles.dart';

class ScrolleableDaysList extends StatefulWidget {
  final List<int> days;
  final List<int> months;
  final int initialDay;
  final int initialMonth;
  final String label;
  final Function(int selectedDay) onSelectedNewDay;
  final Function(int selectedMonth) onSelectedNewMonth;

  const ScrolleableDaysList({
    super.key,
    required this.days,
    required this.months,
    required this.initialDay,
    required this.onSelectedNewDay,
    required this.label,
    required this.initialMonth,
    required this.onSelectedNewMonth,
  });

  @override
  State<ScrolleableDaysList> createState() => _ScrolleableDaysListState();
}

class _ScrolleableDaysListState extends State<ScrolleableDaysList> {
  late int? _selectedDay;
  late int? _selectedMonth;
  @override
  void initState() {
    super.initState();
    _selectedDay = null;
    _selectedMonth = null;
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: resp.hp(5)),
        Text('Select a date:', style: TextStyles.w700(resp.sp16)),
        SizedBox(height: resp.hp(2)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              ...List.generate(
                12,
                (index) {
                  final int monthContainer = index + 1;
                  final bool isSelected =
                      monthContainer == (_selectedMonth ?? widget.initialMonth);
                  return GestureDetector(
                    onTap: () {
                      if ((_selectedMonth ?? widget.initialMonth) ==
                              monthContainer ||
                          !widget.months.contains(monthContainer)) {
                        return;
                      }
                      widget.onSelectedNewDay(monthContainer);
                      setState(() {
                        _selectedMonth = monthContainer;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: monthContainer <= 12 ? 20 : 0,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              DateFormat('MMMM').format(DateTime(
                                DateTime.now().year,
                                monthContainer,
                              )),
                              style: !isSelected
                                  ? TextStyles.w600(resp.sp16, lightGrey)
                                  : TextStyles.w800(resp.sp16),
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
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        SizedBox(height: resp.hp(1)),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              ...List.generate(
                widget.days.length,
                (index) {
                  final int dayContainer = widget.days[index];
                  final bool isSelected =
                      dayContainer == (_selectedDay ?? widget.initialDay);
                  return GestureDetector(
                    onTap: () {
                      if ((_selectedDay ?? widget.initialDay) == dayContainer) {
                        return;
                      }
                      widget.onSelectedNewDay(dayContainer);
                      setState(() {
                        _selectedDay = dayContainer;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index >= 0 && index < widget.days.length - 1
                            ? 20
                            : 0,
                        top: 10,
                        bottom: 20,
                      ),
                      child: Column(
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
                                widget.days[index].toString(),
                                style: TextStyles.w500(resp.sp16,
                                    isSelected ? Colors.white : lightGrey),
                              ),
                            ),
                          ),
                          Text(
                            DateFormat('EEEE')
                                .format(DateTime(DateTime.now().year,
                                    DateTime.now().month, dayContainer))
                                .substring(0, 3)
                                .toUpperCase(),
                            style: isSelected
                                ? TextStyles.w700(resp.sp16)
                                : TextStyles.w500(resp.sp16, lightGrey),
                          ),
                          SizedBox(height: resp.hp(0.5)),
                          if (isSelected)
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
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Text(
          widget.label,
          style: TextStyles.w700(resp.sp16),
        ),
      ],
    );
  }
}
