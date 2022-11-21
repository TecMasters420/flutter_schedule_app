import 'package:flutter/material.dart';
import 'package:schedulemanager/models/reminder_model.dart';
import 'package:schedulemanager/screens/reminder_details_page/reminders_details_page.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/widgets/tags_list.dart';

import '../constants/constants.dart';
import '../utils/text_styles.dart';
import 'custom_button.dart';

class ReminderInformation extends StatelessWidget {
  static const List<String> _tags = [
    'Project',
    'Meeting',
    'Shot Dribbble',
    'Standup',
    'Sprint'
  ];

  final ReminderModel reminder;
  final bool showHourInTop;
  const ReminderInformation({
    super.key,
    required this.reminder,
    required this.showHourInTop,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    final remainingTime = reminder.timeLeft(DateTime.now());

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHourInTop) ...[
          Row(
            children: [
              Text(
                'Hour: ',
                style: TextStyles.w500(resp.sp14, lightGrey),
              ),
              Text(
                '11:00 - 11:30',
                style: TextStyles.w500(
                  resp.sp14,
                  lightGrey,
                ),
              ),
              const Spacer(),
              Icon(
                Icons.more_horiz_rounded,
                color: lightGrey,
                size: resp.dp(2.25),
              )
            ],
          ),
        ],
        SizedBox(height: resp.hp(1)),
        Text(
          reminder.title,
          style: TextStyles.w700(resp.sp16),
          textAlign: TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: resp.hp(1)),
        Text(
          reminder.description,
          style: TextStyles.w400(resp.sp14, grey),
          textAlign: TextAlign.start,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        if (reminder.location != null) ...[
          SizedBox(height: resp.hp(1)),
          Text(
            'Information:',
            style: TextStyles.w700(resp.sp14),
          ),
          SizedBox(height: resp.hp(0.5)),
          Text(
            'Location: ${reminder.location.toString()}',
            style: TextStyles.w500(resp.sp14, grey),
          ),
          Text(
            'Time to arrive: 92 min',
            style: TextStyles.w500(resp.sp14, grey),
          ),
        ],
        SizedBox(height: resp.hp(0.5)),
        if (reminder.tags.isNotEmpty) ...[
          Text(
            'Tags:',
            style: TextStyles.w700(resp.sp14),
          ),
          TagsList(
            tagsList: reminder.tags.map((e) => e.name).toList(),
            maxTagsToShow: 3,
            style: TextStyles.w500(
              resp.dp(1),
            ),
          ),
          SizedBox(height: resp.hp(1)),
        ],
        Row(
          children: [
            if (!reminder.hasExpired(DateTime.now())) ...[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Remaining time:',
                      style: TextStyles.w700(resp.sp14),
                    ),
                    Text(
                      '${remainingTime.inDays} day/s, ${remainingTime.inHours} hours',
                      style: TextStyles.w500(resp.sp14, grey),
                    ),
                  ],
                ),
              ),
            ] else
              Expanded(
                child: Text(
                  'Expired',
                  style: TextStyles.w500(resp.sp14, Colors.red[200]!),
                ),
              ),
            CustomButton(
              constraints: const BoxConstraints(maxWidth: 150),
              text: 'Details',
              color: accent,
              height: resp.hp(4),
              width: resp.wp(15),
              style: TextStyles.w600(resp.sp14, Colors.white),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) =>
                      ReminderDetailsPage(reminder: reminder),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
