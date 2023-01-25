import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:schedulemanager/app/config/app_constants.dart';
import 'package:schedulemanager/app/utils/alert_dialogs_util.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/data/models/tag_model.dart';
import 'package:schedulemanager/data/models/task_model.dart';
import 'package:schedulemanager/modules/event_details_creation/controller/events_details_creation_controller.dart';
import 'package:schedulemanager/modules/event_details_creation/widgets/custom_alert_with_calendart.dart';
import 'package:schedulemanager/modules/event_details_creation/widgets/event_expandible_details_widget.dart';
import 'package:schedulemanager/modules/event_details_creation/widgets/weather_container.dart';
import 'package:schedulemanager/modules/home/widgets/no_events_widget.dart';
import 'package:schedulemanager/routes/app_routes.dart';

import '../../app/config/constants.dart';
import '../../app/services/base_repository.dart';
import '../../app/utils/text_styles.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_header_widget.dart';
import '../../widgets/custom_text_button_widget.dart';
import '../../widgets/loading_widget.dart';
import '../../widgets/map_preview.dart';
import '../../widgets/progress_bar.dart';
import '../../widgets/reminder_information_widget.dart';
import '../../widgets/responsive_container_widget.dart';
import '../../widgets/tags_list.dart';

class NewEventsDetailsCreationPage extends StatelessWidget {
  const NewEventsDetailsCreationPage({super.key});

  String getDateFormatted(DateTime date) {
    final formattedDate =
        DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(date.toUtc());
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final EventsDetailsCreationController controller = Get.find();
    final int? eventId = int.tryParse(Get.arguments.toString());
    debugPrint('Event ID: $eventId');
    if (eventId != null && controller.event.value == null) {
      controller.getEvent(eventId);
    } else if (controller.event.value == null) {
      controller.createEmpty();
    }
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: accent,
        child: Icon(eventId == null ? Icons.add : Icons.check),
        onPressed: () async {
          if (eventId == null) {
            await controller.createEvent();
          } else {
            await controller.editEvent(eventId);
          }
        },
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return const LoadingWidget();
          } else if (controller.event.value == null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                NoEventsWidget(),
              ],
            );
          }
          final event = controller.event.value!;
          final progress = event.progress.isNaN ? 0.0 : event.progress;
          final isSameDay =
              event.startDate.difference(event.endDate).inDays == 0;
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: AppConstants.bodyPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomHeaderWidget(
                    title: event.title.isEmpty ? 'Insert title' : event.title,
                    suffixWidget: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: accent,
                      ),
                      splashRadius: 20,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        await AlertDialogsUtil.withTextField(
                          title: 'Title',
                          initialText: event.title,
                          maxLines: 2,
                          onSummitCallback: (value) {
                            event.title = value;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Text(
                    'Event information',
                    style: TextStyles.w800(20),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  ResponsiveContainerWidget(
                    child: Column(
                      children: [
                        SizedBox(height: resp.hp(2.5)),
                        EventDetailsWidget(
                          icon: Icons.description_outlined,
                          title: 'Description',
                          value: event.description.isEmpty
                              ? 'No description'
                              : event.description,
                          showSuffixWidget: true,
                          onTapEditCallback: () async {
                            await AlertDialogsUtil.withTextField(
                              title: 'Description',
                              initialText: event.description,
                              maxLines: 2,
                              onSummitCallback: (value) {
                                event.description = value;
                              },
                            );
                          },
                        ),
                        EventDetailsWidget(
                          icon: Icons.tag_rounded,
                          title: 'Tags',
                          showSuffixWidget: true,
                          customSuffixWidget: CustomTextButtonWidget(
                            title: 'Add',
                            onTap: () async {
                              await AlertDialogsUtil.withTextField(
                                title: 'Tags',
                                initialText: '',
                                maxLines: 2,
                                onSummitCallback: (value) {
                                  if (value.isEmpty) return;
                                  final tag = TagModel(name: value);
                                  event.tags = [...event.tags, tag];
                                },
                              );
                            },
                          ),
                          extra: TagsList(
                            tagsList: event.tags,
                            maxTagsToShow: event.tags.length,
                            style: TextStyles.w800(
                              14,
                              Colors.white,
                            ),
                            onLongPressCallback: (index) async {
                              AlertDialogsUtil.remove(
                                customBodyMessage: [
                                  'It will be removed from the tag list'
                                ],
                                onAcceptCallback: () {
                                  event.tags = event.tags
                                      .where((t) =>
                                          t.name != event.tags[index].name)
                                      .toList();
                                  Get.back();
                                  controller.event.refresh();
                                },
                              );
                            },
                          ),
                        ),
                        EventDetailsWidget(
                          icon: Icons.list_alt_rounded,
                          title: 'Tasks',
                          showSuffixWidget: true,
                          customSuffixWidget: CustomTextButtonWidget(
                            title: 'Add',
                            onTap: () async {
                              await AlertDialogsUtil.withTextField(
                                title: 'Tasks',
                                initialText: '',
                                maxLines: 2,
                                onSummitCallback: (value) {
                                  if (value.isEmpty) return;
                                  final task = TaskModel(
                                    isCompleted: false,
                                    name: value,
                                  );
                                  event.tasks = [...event.tasks, task];
                                },
                              );
                            },
                          ),
                          extra: Column(
                            children: List.generate(
                              event.tasks.length,
                              (index) {
                                final task = event.tasks[index];
                                return Row(
                                  children: [
                                    Checkbox(
                                      activeColor: accent,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      value: task.isCompleted,
                                      onChanged: (value) {
                                        event.tasks[index].isCompleted = value!;
                                        controller.event.refresh();
                                      },
                                    ),
                                    Expanded(
                                      child: Text(
                                        task.name,
                                        style:
                                            TextStyles.w500(14, grey).copyWith(
                                          decorationColor: grey,
                                          decoration:
                                              event.tasks[index].isCompleted
                                                  ? TextDecoration.lineThrough
                                                  : null,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      splashRadius: 20,
                                      splashColor: red.withOpacity(0.1),
                                      highlightColor: red.withOpacity(0.1),
                                      icon: const Icon(
                                        Icons.remove_circle_outline,
                                        color: lightGrey,
                                        size: 25,
                                      ),
                                      onPressed: () {
                                        AlertDialogsUtil.remove(
                                          customBodyMessage: [
                                            'It will be removed from the tasks list'
                                          ],
                                          onAcceptCallback: () {
                                            event.tasks = event.tasks
                                                .where((t) =>
                                                    t.name !=
                                                    event.tasks[index].name)
                                                .toList();
                                            Get.back();
                                            controller.event.refresh();
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        EventDetailsWidget(
                          icon: Icons.bar_chart_rounded,
                          title: 'Progress',
                          value: '${progress.toStringAsFixed(2)}%',
                          extra: Column(
                            children: [
                              SizedBox(height: resp.hp(1)),
                              ProgressBar(
                                percent: progress,
                                height: resp.hp(2.5),
                                width: resp.wp(70),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Text(
                    'Event Date',
                    style: TextStyles.w800(18),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  ResponsiveContainerWidget(
                    child: Column(
                      children: [
                        EventExpandibleDetailsWidget(
                          icon: Icons.calendar_today_rounded,
                          title: 'Start Date',
                          value:
                              '${isSameDay ? 'Today' : getDateFormatted(event.startDate)} at ${DateFormat('hh:mm a').format(event.startDate)}',
                          body: ScrolleableCalendarWithHour(
                            endDate: DateTime(2020),
                            firstDate: DateTime.now(),
                            onChangesInDate: (date) {
                              event.startDate = date;
                              controller.event.refresh();
                            },
                          ),
                        ),
                        EventExpandibleDetailsWidget(
                          icon: Icons.calendar_today_rounded,
                          title: 'End Date',
                          value:
                              '${isSameDay ? 'Today' : getDateFormatted(event.endDate)} at ${DateFormat('hh:mm a').format(event.endDate)}',
                          body: ScrolleableCalendarWithHour(
                            endDate: DateTime(2020),
                            firstDate: DateTime.now(),
                            onChangesInDate: (date) {
                              event.endDate = date;
                              controller.event.refresh();
                            },
                          ),
                        ),
                        SizedBox(height: resp.hp(1)),
                        EventDetailsWidget(
                          icon: Icons.timer_outlined,
                          title: 'Time remaining',
                          value: event.getExpirationTime(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Text(
                    'Event Weather',
                    style: TextStyles.w800(18),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  // if (reminder.expectedTemp != null)
                  ResponsiveContainerWidget(
                    child: Column(
                      children: [
                        SizedBox(height: resp.hp(2.5)),
                        const EventDetailsWidget(
                          icon: Icons.water_drop_outlined,
                          title: 'Expected weather',
                          extra: WeatherContainer(
                            temp: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Text(
                    'Event Location',
                    style: TextStyles.w800(18),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  ResponsiveContainerWidget(
                    child: Column(
                      children: [
                        SizedBox(height: resp.hp(2.5)),
                        EventDetailsWidget(
                          icon: Icons.location_on_outlined,
                          title: 'Location',
                          value: null,
                          extra: Column(
                            children: [
                              if (event.startLocation != null &&
                                  event.startLocation!.address != null)
                                EventDetailsWidget(
                                  icon: Icons.east_rounded,
                                  title: 'Start location',
                                  value: event.startLocation!.address,
                                ),
                              if (event.endLocation != null &&
                                  event.endLocation!.address != null)
                                EventDetailsWidget(
                                  icon: Icons.west,
                                  title: 'End location',
                                  value: event.endLocation!.address,
                                ),
                              if (event.endLocation != null ||
                                  event.startLocation != null) ...[
                                MapPreview(
                                  height: resp.hp(20),
                                  width: resp.width,
                                  initialPoint: event.startLocation != null
                                      ? GeoPoint(event.startLocation!.lat,
                                          event.startLocation!.lng)
                                      : const GeoPoint(0, 0),
                                  endPoint: event.endLocation != null
                                      ? GeoPoint(event.endLocation!.lat,
                                          event.endLocation!.lng)
                                      : const GeoPoint(0, 0),
                                  onAcceptCallback: (startPos, startAddress,
                                      endPos, endAddress, points) {},
                                  startAddress: event.startLocation!.address,
                                  endAddress: event.endLocation!.address,
                                ),
                              ] else ...[
                                CustomButton(
                                  text: 'Add location',
                                  color: accent,
                                  style: TextStyles.w700(14, Colors.white),
                                  onTap: () => Get.toNamed(AppRoutes.mapPage),
                                )
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
