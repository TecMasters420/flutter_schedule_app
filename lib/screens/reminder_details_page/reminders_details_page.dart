import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:schedulemanager/screens/map_page/map_page.dart';
import '../../constants/constants.dart';
import '../../models/reminder_model.dart';
import '../../models/tag_model.dart';
import '../../models/task_model.dart';
import '../../services/base_service.dart';
import '../../services/reminder_service.dart';
import '../../utils/responsive_util.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_date_time_picker.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/map_preview.dart';
import '../../widgets/progress_bar.dart';
import '../../widgets/reminder_information_widget.dart';
import '../../widgets/tags_list.dart';

import '../../utils/text_styles.dart';
import '../../widgets/custom_back_button.dart';
import 'widgets/widgets.dart';

class ReminderDetailsPage extends StatefulWidget {
  final ReminderModel? reminder;
  const ReminderDetailsPage({
    super.key,
    required this.reminder,
  });

  @override
  State<ReminderDetailsPage> createState() => _ReminderDetailsPageState();
}

class _ReminderDetailsPageState extends State<ReminderDetailsPage> {
  late TagModel tag;
  late TaskModel task;
  late String? address;
  late List<LatLng> _mapPreviewPoints;

  @override
  void initState() {
    super.initState();
    address = null;
    _mapPreviewPoints = [];
    tag = TagModel(name: '');
    task = TaskModel(name: '', isCompleted: false);
  }

  String getDateFormatted(DateTime date) =>
      DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(date.toUtc());

  void _onLocationChanged(final LatLng start, final String? startAddress,
      final LatLng end, final String? endAddress, List<LatLng>? points) {
    setState(() {
      widget.reminder!.startLocation =
          GeoPoint(start.latitude, start.longitude);
      widget.reminder!.endLocation = GeoPoint(end.latitude, end.longitude);
      widget.reminder!.startLocationAddress = startAddress;
      widget.reminder!.endLocationAddress = endAddress;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final ReminderService service = Provider.of<ReminderService>(context);

    final DateTime startDate = widget.reminder!.startDate.toDate();
    final DateTime endDate = widget.reminder!.endDate.toDate();
    final bool isSameDay = startDate.difference(endDate).inDays == 0;
    final double progress =
        widget.reminder!.progress.isNaN ? 0 : widget.reminder!.progress;
    final Duration timeRemaining = widget.reminder!.timeLeft(DateTime.now());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: accent,
        child: const Icon(Icons.check),
        onPressed: () async {
          final idIsEmpty = widget.reminder!.uid.isEmpty;
          await (idIsEmpty
                  ? service.create(widget.reminder!.toMap())
                  : service.update(
                      widget.reminder!.toMap(), widget.reminder!.id ?? ''))
              .whenComplete(
            () {
              Navigator.pop(context);
            },
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          top: 50,
          bottom: 20,
        ),
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const CustomBackButton(),
                  SizedBox(height: resp.hp(2.5)),
                  Center(
                    child: Text(
                      widget.reminder!.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.w700(resp.sp30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Text(
                    widget.reminder!.description,
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
                  Flexible(
                    child: Row(
                      children: [
                        Expanded(
                          child: ReminderInformationWidget(
                            icon: Icons.calendar_today_rounded,
                            title: 'Start Date:',
                            value:
                                '${isSameDay ? 'Today' : getDateFormatted(startDate)} at ${DateFormat('hh:mm a').format(startDate)}',
                          ),
                        ),
                        IconButton(
                          splashRadius: 20,
                          splashColor: accent.withOpacity(0.3),
                          highlightColor: accent.withOpacity(0.25),
                          icon: Icon(
                            Icons.mode,
                            color: lightGrey,
                            size: resp.sp20,
                          ),
                          onPressed: () async {
                            CustomDateTimePicker(
                              context: context,
                              startDate: startDate,
                              endDate: endDate,
                              onAcceptCallback: (date) {
                                setState(() {
                                  widget.reminder!.startDate =
                                      Timestamp.fromDate(date);
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  Flexible(
                    child: Row(
                      children: [
                        Expanded(
                          child: ReminderInformationWidget(
                            icon: Icons.calendar_month_outlined,
                            title: 'End Date:',
                            value:
                                '${isSameDay ? 'Today' : getDateFormatted(endDate)} at ${DateFormat('hh:mm a').format(endDate)}',
                          ),
                        ),
                        IconButton(
                          splashRadius: 20,
                          splashColor: accent.withOpacity(0.3),
                          highlightColor: accent.withOpacity(0.25),
                          icon: Icon(
                            Icons.mode,
                            color: lightGrey,
                            size: resp.sp20,
                          ),
                          onPressed: () async {
                            CustomDateTimePicker(
                              context: context,
                              startDate: startDate,
                              endDate: DateTime(endDate.year + 3),
                              onAcceptCallback: (date) {
                                setState(() {
                                  widget.reminder!.endDate =
                                      Timestamp.fromDate(date);
                                });
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  ReminderInformationWidget(
                    icon: Icons.timer,
                    title: 'Time remaining:',
                    value:
                        '${timeRemaining.isNegative ? 'Expired' : ''} ${timeRemaining.inDays == 0 ? '' : '${timeRemaining.inDays.abs()} day/s, '}${timeRemaining.inHours.abs()} hour/s ${timeRemaining.isNegative ? 'ago' : ''}',
                  ),
                  if (widget.reminder!.expectedTemp != null)
                    ReminderInformationWidget(
                      icon: Icons.location_on_outlined,
                      title: 'Expected weather:',
                      extra: WeatherContainer(
                        temp: widget.reminder!.expectedTemp!,
                      ),
                    ),
                  ReminderInformationWidget(
                    icon: Icons.location_on_outlined,
                    title: 'Location:',
                    value: address ?? '',
                    extra: Column(
                      children: [
                        if (widget.reminder!.startLocationAddress != null)
                          ReminderInformationWidget(
                            icon: Icons.location_pin,
                            title: 'Start location',
                            value: widget.reminder!.startLocationAddress,
                          ),
                        if (widget.reminder!.endLocationAddress != null)
                          ReminderInformationWidget(
                            icon: Icons.location_searching_rounded,
                            title: 'End location',
                            value: widget.reminder!.endLocationAddress,
                          ),
                        if (widget.reminder!.endLocation != null ||
                            widget.reminder!.startLocation != null) ...[
                          MapPreview(
                            height: resp.hp(20),
                            width: resp.width,
                            initialPoint: widget.reminder!.startLocation ??
                                const GeoPoint(0, 0),
                            endPoint: widget.reminder!.endLocation ??
                                const GeoPoint(0, 0),
                            onAcceptCallback: _onLocationChanged,
                            startAddress: widget.reminder!.startLocationAddress,
                            endAddress: widget.reminder!.endLocationAddress,
                          ),
                        ] else ...[
                          CustomButton(
                            text: 'Add location',
                            color: lightGrey.withOpacity(0.25),
                            height: resp.hp(5),
                            width: resp.width,
                            style: TextStyles.w500(resp.sp16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapPage(
                                    onAcceptCallback: _onLocationChanged,
                                  ),
                                ),
                              );
                            },
                          )
                        ]
                      ],
                    ),
                  ),
                  ReminderInformationWidget(
                    icon: Icons.tag_rounded,
                    title: 'Tags:',
                    extra: TagsList(
                      tagsList:
                          widget.reminder!.tags.map((e) => e.name).toList(),
                      maxTagsToShow: widget.reminder!.tags.length,
                      style: TextStyles.w500(
                        resp.sp14,
                      ),
                      onLongPressCallback: (index) {
                        final TagModel selectedTag =
                            widget.reminder!.tags[index];

                        CustomAlertDialog(
                          resp: resp,
                          context: context,
                          title:
                              'Do you want to delete "${selectedTag.name}" tag?',
                          onAcceptCallback: () {
                            setState(() {
                              widget.reminder!.tags.removeAt(index);
                            });
                          },
                        );
                      },
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      CustomButton(
                        text: 'Add Tag',
                        color: lightGrey.withOpacity(0.25),
                        height: resp.hp(4),
                        width: resp.wp(30),
                        style: TextStyles.w500(resp.sp14),
                        prefixWidget: Icon(
                          Icons.add,
                          size: resp.sp16,
                          color: accent,
                        ),
                        onTap: () {
                          CustomAlertDialog(
                            resp: resp,
                            context: context,
                            title: 'Create new Tag',
                            onAcceptCallback: () {
                              setState(() {
                                widget.reminder!.tags.add(tag);
                                tag = TagModel(name: '');
                              });
                            },
                            customBody: CustomFormField(
                              labelText: 'Name',
                              hintText: 'Name',
                              icon: Icons.abc,
                              onChanged: (value) {
                                setState(() {
                                  tag.name = value;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  ReminderInformationWidget(
                    icon: Icons.list_alt_rounded,
                    title: 'Tasks:',
                    extra: Column(
                      children: List.generate(
                        widget.reminder!.tasks.length,
                        (index) {
                          final TaskModel task = widget.reminder!.tasks[index];
                          return Row(
                            children: [
                              Checkbox(
                                activeColor: accent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                value: task.isCompleted,
                                onChanged: (value) {
                                  setState(() {
                                    widget.reminder!.tasks[index].isCompleted =
                                        value!;
                                  });
                                },
                              ),
                              Expanded(
                                child: Text(
                                  task.name,
                                  style: TextStyles.w500(resp.sp14, grey),
                                ),
                              ),
                              IconButton(
                                splashRadius: 20,
                                splashColor: Colors.red.withOpacity(0.3),
                                highlightColor: Colors.red.withOpacity(0.25),
                                icon: Icon(
                                  Icons.remove_circle_outline,
                                  color: lightGrey,
                                  size: resp.sp20,
                                ),
                                onPressed: () {
                                  final TaskModel selectedTask =
                                      widget.reminder!.tasks[index];
                                  CustomAlertDialog(
                                    resp: resp,
                                    context: context,
                                    title:
                                        'Do you want to delete "${selectedTask.name}" task?',
                                    onAcceptCallback: () {
                                      setState(() {
                                        widget.reminder!.tasks.removeAt(index);
                                      });
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      CustomButton(
                        text: 'Add Task',
                        color: lightGrey.withOpacity(0.25),
                        height: resp.hp(4),
                        width: resp.wp(30),
                        style: TextStyles.w500(resp.sp14),
                        prefixWidget: Icon(
                          Icons.add,
                          size: resp.sp16,
                          color: accent,
                        ),
                        onTap: () {
                          CustomAlertDialog(
                            resp: resp,
                            context: context,
                            title: 'Create new Task',
                            onAcceptCallback: () {
                              setState(() {
                                widget.reminder!.tasks.add(task);
                                task = TaskModel(name: '', isCompleted: false);
                              });
                            },
                            customBody: CustomFormField(
                              labelText: 'Name',
                              hintText: 'Name',
                              icon: Icons.abc,
                              onChanged: (value) {
                                setState(() {
                                  task.name = value;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  ReminderInformationWidget(
                    icon: Icons.bar_chart_rounded,
                    title: 'Progress:',
                    value: '$progress%',
                    extra: ProgressBar(
                      percent: progress,
                      height: resp.hp(2.5),
                      width: resp.wp(70),
                    ),
                  ),
                  SizedBox(height: resp.hp(5)),
                ],
              ),
            ),
            ExpandibleCreationOrEditReminder(
              icon: Icons.edit,
              initialHeight: resp.hp(6),
              finalHeight: resp.hp(50),
              initialWidth: resp.wp(13),
              finalWidth: resp.width,
              iconSize: resp.dp(3),
              reminder: widget.reminder,
              onAcceptCallback: (reminder) {
                widget.reminder!.title = reminder.title;
                widget.reminder!.description = reminder.description;
              },
            ),
          ],
        ),
      ),
    );
  }
}
