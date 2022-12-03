import 'package:flutter/material.dart';
import '../../data/models/reminder_model.dart';
import '../pages/reminder_details_page/reminders_details_page.dart';
import '../../app/utils/responsive_util.dart';
import 'progress_bar.dart';
import 'tags_list.dart';

import '../../app/config/constants.dart';
import '../../app/utils/text_styles.dart';
import 'custom_button.dart';

class ReminderInformation extends StatelessWidget {
  final ReminderModel reminder;
  const ReminderInformation({
    super.key,
    required this.reminder,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    final remainingTime = reminder.timeLeft(DateTime.now());

    final String daysMess =
        remainingTime.inDays == 0 ? '' : '${remainingTime.inDays} day/s, ';
    final String hoursMess =
        '${remainingTime.inHours - (remainingTime.inDays * 24)} hours';

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        SizedBox(height: resp.hp(1)),
        Text(
          'Information:',
          style: TextStyles.w700(resp.sp14),
        ),
        if (reminder.endLocation != null &&
            reminder.endLocationAddress != null) ...[
          SizedBox(height: resp.hp(1)),
          Text(
            'End location:',
            style: TextStyles.w600(resp.sp14),
          ),
          Text(
            reminder.endLocationAddress.toString(),
            style: TextStyles.w500(resp.sp14, grey),
          ),
        ],
        if (reminder.startLocation != null &&
            reminder.startLocationAddress != null) ...[
          SizedBox(height: resp.hp(1)),
          Text(
            'Start location:',
            style: TextStyles.w600(resp.sp14),
          ),
          Text(
            reminder.startLocationAddress.toString(),
            style: TextStyles.w500(resp.sp14, grey),
          ),
        ],
        SizedBox(height: resp.hp(1)),
        if (reminder.tags.isNotEmpty) ...[
          Text(
            'Tags:',
            style: TextStyles.w600(resp.sp14),
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
        if (reminder.tasks.isNotEmpty) ...[
          Text(
            'Tasks progress: ${(reminder.progress.isNaN ? 0 : reminder.progress).toStringAsFixed(2)}%',
            style: TextStyles.w600(resp.sp14),
          ),
          SizedBox(height: resp.hp(1)),
          ProgressBar(
            percent: reminder.progress,
            height: resp.hp(1.5),
            width: resp.width,
          ),
          SizedBox(height: resp.hp(2)),
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
                      daysMess + hoursMess,
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
                MaterialPageRoute(
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
