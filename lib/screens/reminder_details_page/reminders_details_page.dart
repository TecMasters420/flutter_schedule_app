import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/constants/constants.dart';
import 'package:schedulemanager/models/reminder_model.dart';
import 'package:schedulemanager/models/task_model.dart';
import 'package:schedulemanager/utils/responsive_util.dart';
import 'package:schedulemanager/widgets/map_preview.dart';
import 'package:schedulemanager/widgets/progress_bar.dart';
import 'package:schedulemanager/widgets/reminder_information_widget.dart';
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

  final ReminderModel? reminder;

  const ReminderDetailsPage({
    super.key,
    required this.reminder,
  });

  String getDateFormatted(DateTime date) {
    return DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(date.toUtc());
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    final DateTime startDate = reminder!.startDate.toDate();
    final DateTime endDate = reminder!.endDate.toDate();
    final bool isSameDay = startDate.difference(endDate).inDays == 0;

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
                  reminder!.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyles.w700(resp.sp30),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: resp.hp(2.5)),
              Text(
                reminder!.description,
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
              SizedBox(height: resp.hp(2.5)),
              ReminderInformationWidget(
                  icon: Icons.calendar_today_rounded,
                  title: 'Start Date:',
                  value:
                      '${isSameDay ? 'Today' : getDateFormatted(startDate)} at ${DateFormat('hh:mm a').format(startDate)}'),
              ReminderInformationWidget(
                  icon: Icons.calendar_month_outlined,
                  title: 'End Date:',
                  value:
                      '${isSameDay ? 'Today' : getDateFormatted(endDate)} at ${DateFormat('hh:mm a').format(endDate)}'),
              ReminderInformationWidget(
                icon: Icons.timer,
                title: 'Time remaining:',
                value:
                    '${reminder!.timeLeft(DateTime.now()).inDays} day/s, ${reminder!.timeLeft(DateTime.now()).inHours} hours',
              ),
              const ReminderInformationWidget(
                icon: Icons.location_on_outlined,
                title: 'Expected weather:',
                extra: WeatherContainer(),
              ),
              const ReminderInformationWidget(
                icon: Icons.location_on_outlined,
                title: 'Location:',
                value: 'Tijuana',
                extra: MapPreview(),
              ),
              ReminderInformationWidget(
                icon: Icons.tag_rounded,
                title: 'Tags:',
                extra: TagsList(
                  tagsList: reminder!.tags.map((e) => e.name).toList(),
                  maxTagsToShow: 3,
                  style: TextStyles.w500(
                    resp.sp14,
                  ),
                ),
              ),
              if (reminder!.tasks.isNotEmpty) ...[
                ReminderInformationWidget(
                    icon: Icons.list_alt_rounded,
                    title: 'Tasks:',
                    extra: Column(
                      children: List.generate(
                        reminder!.tasks.length,
                        (index) {
                          final TaskModel task = reminder!.tasks[index];
                          return Row(
                            children: [
                              Checkbox(
                                activeColor: accent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                value: task.isCompleted,
                                onChanged: (value) {
                                  reminder!.tasks[index].isCompleted = value!;
                                },
                              ),
                              Text(
                                task.name,
                                style: TextStyles.w500(resp.sp14, grey),
                              ),
                            ],
                          );
                        },
                      ),
                    )),
                ReminderInformationWidget(
                  icon: Icons.bar_chart_rounded,
                  title: 'Progress:',
                  value: '90%',
                  extra: ProgressBar(
                      percent: 90, height: resp.hp(2.5), width: resp.wp(70)),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
