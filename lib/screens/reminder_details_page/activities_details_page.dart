import 'package:flutter/material.dart';
import 'package:schedulemanager/constants/constants.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/widgets/map_preview.dart';
import 'package:schedulemanager/widgets/tags_list.dart';
import 'package:schedulemanager/widgets/weather_container.dart';

import '../../utils/text_styles.dart';
import '../../widgets/custom_back_button.dart';

class ReminderDetailsPage extends StatelessWidget {
  static const List<String> _tags = [
    'Project',
    'Meeting',
    'Shot Dribbble',
    'Standup',
    'Sprint'
  ];

  static final Map<IconData, Map<String, List<Widget>>> _bodyElements = {
    Icons.calendar_today_rounded: {'Wednesday, 26 July': []},
    Icons.access_time_sharp: {'12:00 - 14:00': []},
    Icons.supervised_user_circle_outlined: {'Three': []},
    Icons.tag: {
      'Tags': [
        TagsList(
          tagsList: _tags,
          maxTagsToShow: 3,
          style: TextStyles.w500(
            14,
          ),
        ),
      ]
    },
    Icons.location_on_outlined: {
      'South Portland CA, Apple Juice ST.': [const MapPreview()]
    },
    Icons.sunny: {
      'Expected weather for that day': [const WeatherContainer()]
    }
  };
  const ReminderDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: accent,
        child: const Icon(Icons.edit),
        onPressed: () {},
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 50, right: 35, left: 35, bottom: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const CustomBackButton(),
              SizedBox(height: resp.hp(2.5)),
              Center(
                child: Text(
                  'Uber car rentals assistant.',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.w700(resp.sp30),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: resp.hp(2.5)),
              Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
                maxLines: 20,
                overflow: TextOverflow.ellipsis,
                style: TextStyles.w500(resp.sp14),
                textAlign: TextAlign.justify,
              ),
              SizedBox(height: resp.hp(2.5)),
              Text(
                'Reminder information:',
                style: TextStyles.w800(resp.sp16),
              ),
              SizedBox(height: resp.hp(2)),
              ..._bodyElements.entries.map(
                (e) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Icon(
                              e.key,
                              color: grey,
                              size: resp.sp20,
                            ),
                          ),
                        ),
                        SizedBox(width: resp.wp(2.5)),
                        Flexible(
                          flex: 10,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ...e.value.keys.map(
                                (e) => Text(
                                  e,
                                  style: TextStyles.w500(resp.sp14),
                                ),
                              ),
                              SizedBox(height: resp.hp(1)),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Column(
                                  children: e.value.values.map((e) => e).first,
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: resp.wp(5)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
