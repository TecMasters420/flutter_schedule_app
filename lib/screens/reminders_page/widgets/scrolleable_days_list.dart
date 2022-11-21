import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/constants/constants.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/utils/text_styles.dart';

class ScrolleableDaysList extends StatefulWidget {
  final int days;
  final int initialDay;
  final Function(int selectedDay) onSelectedNewDay;

  const ScrolleableDaysList({
    super.key,
    required this.days,
    required this.initialDay,
    required this.onSelectedNewDay,
  });

  @override
  State<ScrolleableDaysList> createState() => _ScrolleableDaysListState();
}

class _ScrolleableDaysListState extends State<ScrolleableDaysList> {
  late int _selectedDay;
  @override
  void initState() {
    super.initState();
    _selectedDay = widget.initialDay;
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: [
          ...List.generate(
            widget.days,
            (index) {
              final isSelected = index == _selectedDay;
              return GestureDetector(
                onTap: () {
                  widget.onSelectedNewDay(index + 1);
                  setState(() {
                    _selectedDay = index;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(
                    right: index >= 0 && index < widget.days - 1 ? 20 : 0,
                    top: 20,
                    bottom: 20,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        DateFormat('EEEE')
                            .format(DateTime(DateTime.now().year,
                                DateTime.now().month, index + 1))
                            .substring(0, 3)
                            .toUpperCase(),
                        style: isSelected
                            ? TextStyles.w700(resp.sp16)
                            : TextStyles.w500(resp.sp16, lightGrey),
                      ),
                      SizedBox(height: resp.hp(0.5)),
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
                            (index + 1).toString(),
                            style: TextStyles.w500(resp.sp16,
                                isSelected ? Colors.white : lightGrey),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
