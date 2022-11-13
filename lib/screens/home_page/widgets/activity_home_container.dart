import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/utils/text_styles.dart';
import 'package:schedulemanager/widgets/custom_button.dart';

import '../../../constants/constants.dart';
import '../../../widgets/map_preview.dart';

class ActivityHomeContainer extends StatelessWidget {
  final int index;
  const ActivityHomeContainer({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: resp.hp(2)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Container(
                    height: 5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colors[Random().nextInt(colors.length - 1)],
                    ),
                  ),
                  Text(
                    '${index + 1}',
                    style: TextStyles.w500(resp.dp(1.75)),
                  ),
                  Text(
                    DateFormat('EEEE')
                        .format(DateTime(DateTime.now().year,
                            DateTime.now().month, index + 1))
                        .substring(0, 3),
                    style: TextStyles.w500(resp.dp(1.75)),
                  ),
                  Text(
                    DateFormat('MMMM').format(DateTime.now()).substring(0, 3),
                    style: TextStyles.w500(resp.dp(1.75)),
                  ),
                ],
              ),
            ),
            SizedBox(width: resp.wp(5)),
            Expanded(
              flex: 10,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        'Hour: ',
                        style: TextStyles.w500(resp.dp(1.15), lightGrey),
                      ),
                      Text(
                        '11:00 - 11:30',
                        style: TextStyles.w500(
                          resp.dp(1.15),
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
                  SizedBox(height: resp.hp(1)),
                  Text(
                    'Bussiness meeting with Samasdasdasda',
                    style: TextStyles.w700(resp.dp(1.75)),
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: resp.hp(1)),
                  Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum',
                    style: TextStyles.w400(resp.dp(1.25), grey),
                    textAlign: TextAlign.start,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (Random().nextInt(100) < 50) ...[
                    SizedBox(height: resp.hp(2)),
                    Text(
                      'Location: South Portland',
                      style: TextStyles.w600(resp.dp(1.5)),
                    ),
                    SizedBox(height: resp.hp(0.5)),
                    Row(
                      children: [
                        Text(
                          'Time to arrive: ',
                          style: TextStyles.w400(resp.dp(1.25), grey),
                        ),
                        Text(
                          '92 min',
                          style: TextStyles.w400(resp.dp(1.25), grey),
                        ),
                      ],
                    ),
                    SizedBox(height: resp.hp(2)),
                    const MapPreview(),
                  ],
                  SizedBox(height: resp.hp(2)),
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Time left: ',
                            style: TextStyles.w400(resp.dp(1.25), grey),
                          ),
                          Text(
                            '1 day',
                            style: TextStyles.w400(resp.dp(1.25), grey),
                          ),
                        ],
                      ),
                      const Spacer(),
                      CustomButton(
                        constraints: const BoxConstraints(maxWidth: 150),
                        text: 'Details',
                        color: accent,
                        height: resp.hp(4),
                        width: resp.wp(15),
                        style: TextStyles.w600(resp.dp(1.15), Colors.white),
                        onTap: () => Navigator.pushNamed(
                            context, 'activitiesDetailsPage'),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        SizedBox(height: resp.hp(1)),
        Divider(
          color: lightGrey.withOpacity(0.15),
          height: resp.dp(2),
        )
      ],
    );
  }
}
