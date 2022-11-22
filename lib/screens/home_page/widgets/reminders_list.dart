import 'package:flutter/material.dart';
import '../../../models/reminder_model.dart';
import 'reminder_date_data.dart';
import '../../../utils/responsive_util.dart';

import '../../../constants/constants.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/reminder_container.dart';
import '../../../widgets/reminder_information.dart';

class RemindersListPerType extends StatelessWidget {
  final List<ReminderModel> data;
  final int maxRemindersToShow;
  const RemindersListPerType({
    super.key,
    required this.data,
    required this.maxRemindersToShow,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Column(
      children: [
        SizedBox(height: resp.hp(1)),
        Divider(
          color: lightGrey.withOpacity(0.15),
          height: resp.hp(1),
          thickness: 0.5,
        ),
        SizedBox(height: resp.hp(1)),
        Row(
          children: [
            Text(
              '${data.length} Reminders',
              style: TextStyles.w700(resp.sp16, black),
            ),
            const Spacer(),
            CustomButton(
              color: lightGrey.withOpacity(0.2),
              text: 'See all',
              height: resp.hp(4),
              style: TextStyles.w500(resp.sp16),
              width: double.infinity,
              constraints: const BoxConstraints(maxWidth: 90),
              prefixWidget: Icon(Icons.add, size: resp.sp20, color: accent),
              onTap: () {
                Navigator.pushNamed(context, 'remindersPage');
              },
            ),
          ],
        ),
        SizedBox(height: resp.hp(2.5)),
        if (data.isNotEmpty) ...[
          ...List.generate(
            data.length > maxRemindersToShow
                ? maxRemindersToShow + 2
                : data.length,
            (index) => index <= maxRemindersToShow
                ? ReminderContainer(
                    index: index,
                    leftWidget: ReminderDateData(
                      endDate: data[index].endDate.toDate(),
                      timeRemaining: data[index].timeLeft(DateTime.now()),
                    ),
                    middleWidget: const SizedBox(),
                    rightWidget: ReminderInformation(
                      reminder: data[index],
                    ),
                  )
                : GestureDetector(
                    onTap: () => Navigator.pushNamed(context, 'remindersPage'),
                    child: Container(
                      height: resp.hp(10),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: lightGrey.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Press to see all reminders',
                            textAlign: TextAlign.center,
                            style: TextStyles.w600(
                              resp.sp16,
                              grey.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
          )
        ] else
          Center(
            child: Text(
              'No Activities',
              style: TextStyles.w500(resp.sp14, lightGrey),
            ),
          ),
      ],
    );
  }
}
