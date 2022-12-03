import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/presentation/controllers/reminders_controller.dart';
import 'package:schedulemanager/presentation/pages/home_page/widgets/all_reminders_redirection_button.dart';
import 'package:schedulemanager/presentation/pages/reminders_page/reminders_page.dart';
import '../../../../data/models/reminder_model.dart';
import 'reminder_date_data.dart';
import '../../../../app/utils/responsive_util.dart';

import '../../../../app/config/constants.dart';
import '../../../../app/utils/text_styles.dart';
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
                Get.to(() => const RemindersPage())!
                    .whenComplete(() => Get.delete<RemindersController>());
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
                    color: colors[Random().nextInt(colors.length - 1)],
                    leftWidget: ReminderDateData(
                      endDate: data[index].endDate.toDate(),
                      timeRemaining: data[index].timeLeft(DateTime.now()),
                    ),
                    rightWidget: ReminderInformation(
                      reminder: data[index],
                    ),
                  )
                : const AllRemindersRedirectionButton(),
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
