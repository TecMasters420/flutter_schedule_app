import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../constants/constants.dart';
import '../../../utils/responsive_util.dart';
import '../../../utils/text_styles.dart';

class ScrolleableDaysList extends StatefulWidget {
  final List<int> days;
  final int initialDay;
  final String label;
  final Function(int selectedDay) onSelectedNewDay;

  const ScrolleableDaysList({
    super.key,
    required this.days,
    required this.initialDay,
    required this.onSelectedNewDay,
    required this.label,
  });

  @override
  State<ScrolleableDaysList> createState() => _ScrolleableDaysListState();
}

class _ScrolleableDaysListState extends State<ScrolleableDaysList> {
  late int? _selectedDay;
  @override
  void initState() {
    super.initState();
    _selectedDay = null;
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: resp.hp(5)),
        Text(
          widget.label,
          style: TextStyles.w700(resp.sp20),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: Row(
            children: [
              ...List.generate(
                widget.days.length,
                (index) {
                  final int containerDay = widget.days[index];
                  final bool isSelected =
                      containerDay == (_selectedDay ?? widget.initialDay);
                  return GestureDetector(
                    onTap: () {
                      if (_selectedDay == containerDay) return;
                      widget.onSelectedNewDay(containerDay);
                      setState(() {
                        _selectedDay = containerDay;
                      });
                    },
                    child: Padding(
                      padding: EdgeInsets.only(
                        right: index >= 0 && index < widget.days.length - 1
                            ? 20
                            : 0,
                        top: 20,
                        bottom: 20,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            DateFormat('EEEE')
                                .format(DateTime(DateTime.now().year,
                                    DateTime.now().month, containerDay))
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
                                widget.days[index].toString(),
                                style: TextStyles.w500(resp.sp16,
                                    isSelected ? Colors.white : lightGrey),
                              ),
                            ),
                          ),
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
              )
            ],
          ),
        ),
      ],
    );
  }
}
