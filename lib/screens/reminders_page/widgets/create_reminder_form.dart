import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/utils/responsive_util.dart';

import '../../../constants/constants.dart';
import '../../../utils/text_styles.dart';
import '../../../widgets/custom_form_field.dart';
import '../../../widgets/tags_list.dart';

class CreateReminderForm extends StatelessWidget {
  static const List<String> _types = [
    'Project',
    'Meeting',
    'Shot Dribbble',
    'Standup',
    'Sprint'
  ];

  const CreateReminderForm({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: resp.hp(1)),
        Text(
          'Title',
          style: TextStyles.w600(resp.sp14),
        ),
        SizedBox(height: resp.hp(1)),
        CustomFormField(
          labelText: 'Title',
          hintText: 'my title',
          icon: Icons.my_library_books_outlined,
          onChanged: (value) {},
        ),
        SizedBox(height: resp.hp(1)),
        Text(
          'Description',
          style: TextStyles.w600(resp.sp14),
        ),
        SizedBox(height: resp.hp(1)),
        CustomFormField(
          labelText: 'Description',
          hintText: 'My description',
          icon: Icons.mode_edit_outline_outlined,
          onChanged: (value) {},
        ),
        SizedBox(height: resp.hp(1)),
        Text(
          'Tag',
          style: TextStyles.w600(resp.sp14),
        ),
        SizedBox(height: resp.hp(1)),
        TagsList(
          tagsList: _types,
          style: TextStyles.w500(
            resp.dp(1),
          ),
        ),
        SizedBox(height: resp.hp(1)),
        Text(
          'Date',
          style: TextStyles.w600(resp.sp14),
        ),
        SizedBox(height: resp.hp(1)),
        Row(
          children: [
            const Flexible(
              child: Icon(
                Icons.calendar_month_outlined,
                color: lightGrey,
              ),
            ),
            Expanded(
              child: Text(
                DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(
                  DateTime.now().toUtc(),
                ),
                style: TextStyles.w300(
                  resp.sp14,
                  lightGrey,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: resp.hp(1.5)),
        Text(
          'Duration',
          style: TextStyles.w600(resp.sp14),
        ),
        SizedBox(height: resp.hp(1.5)),
        Row(
          children: [
            const Flexible(
              child: Icon(
                Icons.watch_later_outlined,
                color: lightGrey,
              ),
            ),
            Expanded(
              child: Text(
                '10:00 - 11:00',
                style: TextStyles.w300(
                  resp.sp14,
                  lightGrey,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: resp.hp(1.5)),
        Text(
          'Location',
          style: TextStyles.w600(resp.sp14),
        ),
        SizedBox(height: resp.hp(1.5)),
        Row(
          children: [
            const Flexible(
              child: Icon(
                Icons.location_on_outlined,
                color: lightGrey,
              ),
            ),
            Expanded(
              child: Text(
                'Tijuana, BC',
                style: TextStyles.w300(
                  resp.sp14,
                  lightGrey,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
