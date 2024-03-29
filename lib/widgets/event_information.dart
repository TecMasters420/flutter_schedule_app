import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:schedulemanager/app/utils/share_util.dart';
import 'package:schedulemanager/routes/app_routes.dart';
import '../data/models/event_model.dart';
import '../app/utils/responsive_util.dart';
import 'progress_bar.dart';
import 'tags_list.dart';

import '../app/config/constants.dart';
import '../app/utils/text_styles.dart';
import 'custom_button.dart';

class EventInforamtion extends StatelessWidget {
  final EventModel event;
  const EventInforamtion({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final styles = TextStyles.of(context);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image.asset(
        //   'assets/images/home_logo.png',
        //   height: resp.hp(15),
        //   width: resp.width,
        //   fit: BoxFit.fill,
        // ),
        if (event.tags.isNotEmpty) ...[
          TagsList(
            tagsList: event.tags,
            maxTagsToShow: event.tags.length,
            onLongPressCallback: (index) async {},
          ),
        ],
        Text(
          event.title,
          style: styles.w800(16),
          textAlign: TextAlign.start,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: resp.hp(0.5)),
        Text(
          event.description,
          style: styles.w400(14, grey),
          textAlign: TextAlign.start,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: resp.hp(2)),
        Text(
          'Event Information',
          style: styles.w800(16),
        ),
        if (event.endLocation != null &&
            event.endLocation!.address != null) ...[
          SizedBox(height: resp.hp(1)),
          Text(
            'End location',
            style: styles.w800(14),
          ),
          SizedBox(height: resp.hp(0.5)),
          Text(
            event.endLocation!.address.toString(),
            style: styles.w500(14, grey),
          ),
        ],
        if (event.startLocation != null &&
            event.startLocation!.address != null) ...[
          SizedBox(height: resp.hp(1)),
          Text(
            'Start location',
            style: styles.w800(14),
          ),
          SizedBox(height: resp.hp(0.5)),
          Text(
            event.startLocation!.address.toString(),
            style: styles.w500(14, grey),
          ),
        ],

        if (event.tasks.isNotEmpty) ...[
          SizedBox(height: resp.hp(1)),
          Text(
            'Tasks progress',
            style: styles.w800(14),
          ),
          SizedBox(height: resp.hp(0.5)),
          Text(
            '${(event.progress.isNaN ? 0 : event.progress).toStringAsFixed(2)}%',
            style: styles.w500(14, grey),
          ),
          SizedBox(height: resp.hp(1)),
          ProgressBar(
            percent: event.progress,
            height: resp.hp(1.5),
            width: resp.width,
          ),
          // SizedBox(height: resp.hp(2)),
        ],
        SizedBox(height: resp.hp(1)),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Due',
                    style: styles.w800(14),
                  ),
                  SizedBox(height: resp.hp(0.5)),
                  Text(
                    event.getExpirationTime(),
                    style: styles.w500(14, grey),
                  )
                ],
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
              text: 'Share',
              color: lightBlue,
              hideShadows: true,
              style: styles.w700(14, blueAccent),
              onTap: () async => await ShareUtil.generate(
                'I invite you to the event: ${event.title}',
                'I invite you to the event: ${event.title}',
              ),
            ),
            SizedBox(width: resp.wp(2.5)),
            CustomButton(
              constraints: const BoxConstraints(maxWidth: 150),
              text: 'Details',
              color: blueAccent,
              hideShadows: true,
              style: styles.w700(14, Colors.white),
              onTap: () =>
                  Get.toNamed(AppRoutes.eventDetails, arguments: event.id),
            ),
          ],
        )
      ],
    );
  }
}
