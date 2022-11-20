import 'package:flutter/material.dart';
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

  final bool containData;
  final bool showHourInTop;
  const ReminderInformation({
    super.key,
    required this.containData,
    required this.showHourInTop,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

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
          'Bussiness meeting with Samasdasdasda',
          style: TextStyles.w700(resp.sp16),
          textAlign: TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: resp.hp(1)),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
          style: TextStyles.w400(resp.sp14, grey),
          textAlign: TextAlign.start,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        if (containData) ...[
          SizedBox(height: resp.hp(1)),
          Text(
            'Information:',
            style: TextStyles.w700(resp.sp14),
          ),
          SizedBox(height: resp.hp(0.5)),
          Text(
            'Location: South Portland',
            style: TextStyles.w500(resp.sp14),
          ),
          Text(
            'Time to arrive: 92 min',
            style: TextStyles.w500(resp.sp14),
          ),
        ],
        SizedBox(height: resp.hp(0.5)),
        Text(
          'Tags:',
          style: TextStyles.w700(resp.sp14),
        ),
        TagsList(
          tagsList: _tags,
          maxTagsToShow: 3,
          style: TextStyles.w500(
            resp.dp(1),
          ),
        ),
        SizedBox(height: resp.hp(1)),
        Row(
          children: [
            Text(
              'Time left: 1 day',
              style: TextStyles.w500(resp.sp14, grey),
            ),
            const Spacer(),
            CustomButton(
              constraints: const BoxConstraints(maxWidth: 150),
              text: 'Details',
              color: accent,
              height: resp.hp(4),
              width: resp.wp(15),
              style: TextStyles.w600(resp.sp14, Colors.white),
              onTap: () => Navigator.pushNamed(context, 'reminderDetailsPage'),
            )
          ],
        ),
      ],
    );
  }
}
