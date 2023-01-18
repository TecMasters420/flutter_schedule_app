import 'package:flutter/material.dart';
import '../data/models/event_status_enum.dart';
import '../data/models/reminder_model.dart';
import '../modules/reminder_details/reminders_details_page.dart';
import '../app/utils/responsive_util.dart';
import 'progress_bar.dart';
import 'tags_list.dart';

import '../app/config/constants.dart';
import '../app/utils/text_styles.dart';
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
          style: TextStyles.w700(16),
          textAlign: TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: resp.hp(0.5)),
        Text(
          reminder.description,
          style: TextStyles.w400(14, grey),
          textAlign: TextAlign.start,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: resp.hp(2)),
        Text(
          'Event Information',
          style: TextStyles.w700(16),
        ),
        if (reminder.endLocation != null &&
            reminder.endLocation!.address != null) ...[
          SizedBox(height: resp.hp(1)),
          Text(
            'End location',
            style: TextStyles.w700(14),
          ),
          SizedBox(height: resp.hp(0.5)),
          Text(
            reminder.endLocation!.address.toString(),
            style: TextStyles.w500(14, grey),
          ),
        ],
        if (reminder.startLocation != null &&
            reminder.startLocation!.address != null) ...[
          SizedBox(height: resp.hp(1)),
          Text(
            'Start location',
            style: TextStyles.w700(14),
          ),
          SizedBox(height: resp.hp(0.5)),
          Text(
            reminder.startLocation!.address.toString(),
            style: TextStyles.w500(14, grey),
          ),
        ],
        if (reminder.tags.isNotEmpty) ...[
          SizedBox(height: resp.hp(1)),
          Text(
            'Tags',
            style: TextStyles.w700(14),
          ),
          TagsList(
            tagsList: reminder.tags.map((e) => e.name).toList(),
            maxTagsToShow: 3,
            style: TextStyles.w700(12, Colors.white),
          ),
        ],
        if (reminder.tasks.isNotEmpty) ...[
          SizedBox(height: resp.hp(1)),
          Text(
            'Tasks progress',
            style: TextStyles.w700(14),
          ),
          SizedBox(height: resp.hp(0.5)),
          Text(
            '${(reminder.progress.isNaN ? 0 : reminder.progress).toStringAsFixed(2)}%',
            style: TextStyles.w500(14, grey),
          ),
          SizedBox(height: resp.hp(1)),
          ProgressBar(
            percent: reminder.progress,
            height: resp.hp(1.5),
            width: resp.width,
          ),
          // SizedBox(height: resp.hp(2)),
        ],
        SizedBox(height: resp.hp(1)),
        Row(
          children: [
            if (reminder.currentStatus != EventStatus.expired) ...[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Due',
                      style: TextStyles.w700(14),
                    ),
                    Text(
                      daysMess + hoursMess,
                      style: TextStyles.w500(14, grey),
                    ),
                  ],
                ),
              ),
            ] else
              Expanded(
                child: Text(
                  'Expired',
                  style: TextStyles.w500(14, Colors.red[200]!),
                ),
              ),
          ],
        ),
        SizedBox(height: resp.hp(1)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButton(
              constraints: const BoxConstraints(maxWidth: 150),
              text: 'Details',
              color: lightBlue,
              height: resp.hp(4),
              width: resp.wp(15),
              style: TextStyles.w700(14, accent),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      ReminderDetailsPage(reminder: reminder),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
