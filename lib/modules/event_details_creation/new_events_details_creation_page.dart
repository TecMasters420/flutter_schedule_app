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
import 'package:schedulemanager/modules/map_page/map_page.dart';
import 'package:schedulemanager/widgets/custom_icon_buttton_widget.dart';

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
    final styles = TextStyles.of(context);
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
        backgroundColor: blueAccent,
        child: Icon(eventId == null ? Icons.add : Icons.check),
        onPressed: () async {
          final type = eventId == null ? 'created' : 'edited';
          AlertDialogsUtil.loadingModal(
            context: context,
            subtitle: 'Wait a bit while your event is $type',
          );
          bool isCorrect = false;
          if (eventId == null) {
            isCorrect = await controller.createEvent();
          } else {
            isCorrect = await controller.editEvent(eventId);
          }
          Get.back();
          if (isCorrect) {
            Get.close(1);
            AlertDialogsUtil.completedModal(
              context: context,
              title: 'Completed!',
              subtitle: 'The event has been $type!',
            );
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
                        color: blueAccent,
                      ),
                      splashRadius: 20,
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.zero,
                      onPressed: () async {
                        AlertDialogsUtil.textFieldModal(
                          context: context,
                          initialText: event.title,
                          fieldName: 'Title',
                          subtitle: 'Enter the data to set your event title',
                          onAcceptCallback: (value) {
                            event.title = value;
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  ResponsiveContainerWidget(
                    child: Column(
                      children: [
                        Text(
                          'Event information',
                          style: styles.w800(20),
                        ),
                        SizedBox(height: resp.hp(2.5)),
                        EventDetailsWidget(
                          iconColor: green,
                          icon: Icons.description_outlined,
                          title: 'Description',
                          value: event.description.isEmpty
                              ? 'No description'
                              : event.description,
                          showSuffixWidget: true,
                          onTapEditCallback: () async {
                            AlertDialogsUtil.textFieldModal(
                              context: context,
                              initialText: event.description,
                              fieldName: 'Description',
                              subtitle:
                                  'Enter the data to set your event description',
                              onAcceptCallback: (value) {
                                event.description = value;
                              },
                            );
                          },
                        ),
                        EventDetailsWidget(
                          iconColor: red,
                          icon: Icons.tag_rounded,
                          title: 'Tags',
                          showSuffixWidget: true,
                          customSuffixWidget: CustomTextButtonWidget(
                            title: 'Add',
                            onTap: () async {
                              AlertDialogsUtil.textFieldModal(
                                context: context,
                                initialText: '',
                                fieldName: 'Tag',
                                subtitle: 'Enter the data to add your new tag',
                                onAcceptCallback: (value) {
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
                            onLongPressCallback: (index) {
                              AlertDialogsUtil.removeModal(
                                context: context,
                                subtitle:
                                    'It will be removed from the tag list',
                                onAcceptCallback: () {
                                  event.tags = event.tags
                                      .where((t) =>
                                          t.name != event.tags[index].name)
                                      .toList();
                                  controller.event.refresh();
                                },
                              );
                            },
                          ),
                        ),
                        EventDetailsWidget(
                          iconColor: orange,
                          icon: Icons.list_alt_rounded,
                          title: 'Tasks',
                          showSuffixWidget: true,
                          customSuffixWidget: CustomTextButtonWidget(
                            title: 'Add',
                            onTap: () async {
                              AlertDialogsUtil.textFieldModal(
                                context: context,
                                initialText: '',
                                fieldName: 'Task',
                                subtitle:
                                    'Enter the data to set your event task',
                                onAcceptCallback: (value) {
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
                                final isCompleted =
                                    event.tasks[index].isCompleted;
                                final style = isCompleted
                                    ? styles.w700(14).copyWith(
                                          decorationColor: black,
                                          decorationThickness: 5,
                                          decoration: isCompleted
                                              ? TextDecoration.lineThrough
                                              : null,
                                        )
                                    : styles.w500(14, grey);
                                return Row(
                                  children: [
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          final isSelected = task.isCompleted;
                                          event.tasks[index].isCompleted =
                                              !isSelected;
                                          controller.event.refresh();
                                        },
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 20,
                                              child: Checkbox(
                                                activeColor: green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                                value: task.isCompleted,
                                                onChanged: (value) {},
                                              ),
                                            ),
                                            const SizedBox(width: 10),
                                            Expanded(
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: AnimatedSwitcher(
                                                  duration: const Duration(
                                                    milliseconds: 250,
                                                  ),
                                                  transitionBuilder:
                                                      (child, animation) {
                                                    return ScaleTransition(
                                                      scale: animation,
                                                      child: child,
                                                    );
                                                  },
                                                  child: !isCompleted
                                                      ? Text(
                                                          key: const Key(
                                                              'false'),
                                                          task.name,
                                                          style: style,
                                                        )
                                                      : Text(
                                                          key:
                                                              const Key('true'),
                                                          task.name,
                                                          style: style,
                                                        ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    CustomIconButtonWidget(
                                      color: lightGrey,
                                      size: 20,
                                      icon:
                                          Icons.remove_circle_outline_outlined,
                                      onTapCallback: () {
                                        AlertDialogsUtil.removeModal(
                                          context: context,
                                          subtitle:
                                              'It will be removed from the tasks list',
                                          onAcceptCallback: () {
                                            event.tasks = event.tasks
                                                .where((t) =>
                                                    t.name !=
                                                    event.tasks[index].name)
                                                .toList();
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
                          iconColor: blueAccent,
                          icon: Icons.bar_chart_rounded,
                          title: 'Tasks Progress',
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
                  ResponsiveContainerWidget(
                    child: Column(
                      children: [
                        Text(
                          'Event Date',
                          style: styles.w800(18),
                        ),
                        SizedBox(height: resp.hp(2.5)),
                        EventExpandibleDetailsWidget(
                          icon: Icons.calendar_today_rounded,
                          iconColor: green,
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
                          iconColor: salmon,
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
                          iconColor: purple,
                          icon: Icons.timer_outlined,
                          title: 'Time remaining',
                          value: event.getExpirationTime(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  ResponsiveContainerWidget(
                    child: Column(
                      children: [
                        Text(
                          'Event Weather',
                          style: styles.w800(18),
                        ),
                        SizedBox(height: resp.hp(2.5)),
                        const EventDetailsWidget(
                          iconColor: blueAccent,
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
                  ResponsiveContainerWidget(
                    child: Column(
                      children: [
                        Text(
                          'Event Locations',
                          style: styles.w800(18),
                        ),
                        SizedBox(height: resp.hp(2.5)),
                        EventDetailsWidget(
                          iconColor: purple,
                          icon: Icons.location_on_outlined,
                          title: 'Location',
                          value: null,
                          extra: Column(
                            children: [
                              if (event.startLocation != null &&
                                  event.startLocation!.address != null)
                                EventDetailsWidget(
                                  iconColor: green,
                                  icon: Icons.east_rounded,
                                  title: 'Start location',
                                  value: event.startLocation!.address,
                                ),
                              if (event.endLocation != null &&
                                  event.endLocation!.address != null)
                                EventDetailsWidget(
                                  icon: Icons.west,
                                  iconColor: red,
                                  title: 'End location',
                                  value: event.endLocation!.address,
                                ),
                              if (event.endLocation != null ||
                                  event.startLocation != null) ...[
                                MapPreview(
                                  height: resp.hp(20),
                                  width: resp.width,
                                  endLoc: event.endLocation!,
                                  startLoc: event.startLocation!,
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
                                  color: blueAccent,
                                  style: styles.w700(14, Colors.white),
                                  onTap: () => Get.to(
                                    () => MapPage(
                                      startLoc: event.startLocation,
                                      endLoc: event.endLocation,
                                    ),
                                  ),
                                )
                              ]
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: resp.hp(7)),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
