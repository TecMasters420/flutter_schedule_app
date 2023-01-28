import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/responsive_util.dart';
import '../../../app/utils/text_styles.dart';
import '../../events_page/widgets/date_container.dart';

class ScrolleableCalendarWithHour extends StatelessWidget {
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
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    int selectedMonth = firstDate.month;
    int selectedDay = firstDate.day;

    final now = DateTime(DateTime.now().year, selectedMonth);
    final daysInMonth =
        DateTime(now.year, now.month + 1).toUtc().difference(now).inDays;

    final daysToShow = List.generate(daysInMonth, (d) => d + 1);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Text('Select your date', style: TextStyles.w700(16)),
        // SizedBox(height: resp.hp(1)),
        CustomDateContainer(
          data: List.generate(12, (index) => index + 1),
          initialElementIndex: 0,
          onPressElement: (itemPressed, index) {
            selectedMonth = itemPressed;
            onChangesInDate(
              DateTime(firstDate.year, itemPressed, selectedDay),
            );
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
                  style: isSelected
                      ? TextStyles.w700(14)
                      : TextStyles.w500(
                          14,
                          grey,
                        ),
                ),
                SizedBox(height: resp.hp(0.5)),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  height: 5,
                  width: 20,
                  decoration: BoxDecoration(
                    color: isSelected ? blueAccent : Colors.transparent,
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                  ),
                )
              ],
            );
          },
        ),
        SizedBox(height: resp.hp(1.5)),
        CustomDateContainer(
          data: daysToShow,
          initialElementIndex: 0,
          onPressElement: (itemPressed, index) {
            selectedDay = itemPressed;
            onChangesInDate(
              DateTime(firstDate.year, selectedMonth, itemPressed),
            );
          },
          widgetBuild: (currentElement, isSelected, index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Container(
                    constraints: const BoxConstraints(
                      minWidth: 65,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected ? blueAccent : containerBg,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      children: [
                        Text(
                          daysToShow[index].toString().length == 1
                              ? '0${daysToShow[index]}'
                              : daysToShow[index].toString(),
                          style: TextStyles.w700(
                            14,
                            isSelected ? Colors.white : black,
                          ),
                        ),
                        Text(
                          DateFormat('EEEE')
                              .format(
                                DateTime(
                                  DateTime.now().year,
                                  selectedMonth,
                                  currentElement,
                                ),
                              )
                              .substring(0, 3)
                              .toUpperCase(),
                          style: TextStyles.w500(
                            12,
                            isSelected ? Colors.white : grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: resp.hp(0.5)),
                Container(
                  height: 7,
                  width: 7,
                  decoration: BoxDecoration(
                    color: isSelected ? blueAccent : null,
                    shape: BoxShape.circle,
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
