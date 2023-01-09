import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:schedulemanager/widgets/event_page_header_widget.dart';
import '../../data/models/event_location_model.dart';
import '../map_page/map_page.dart';
import '../../app/config/constants.dart';
import '../../data/models/reminder_model.dart';
import '../../data/models/tag_model.dart';
import '../../data/models/task_model.dart';
import '../../app/services/base_repository.dart';
import '../../app/utils/responsive_util.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/map_preview.dart';
import '../../widgets/progress_bar.dart';
import '../../widgets/reminder_information_widget.dart';
import '../../widgets/tags_list.dart';

import '../../app/utils/text_styles.dart';

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
  late final ReminderModel _reminder;
  late TagModel tag;
  late TaskModel task;
  late String? address;
  late DateTime? _selectedStartDate;
  late DateTime? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    _reminder = widget.reminder!;
    if (widget.reminder!.endDate != null &&
        widget.reminder!.startDate != null) {
      _selectedEndDate = widget.reminder!.endDate;
      _selectedStartDate = widget.reminder!.startDate;
    } else {
      _selectedEndDate = null;
      _selectedStartDate = null;
    }
    address = null;
    tag = TagModel(name: '');
    task = TaskModel(name: '', isCompleted: false);
  }

  String getDateFormatted(DateTime date) {
    final formattedDate =
        DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(date.toUtc());
    return formattedDate;
  }

  void _onLocationChanged(final LatLng start, final String? startAddress,
      final LatLng end, final String? endAddress, List<LatLng>? points) {
    setState(() {
      _reminder.startLocation = EventLocation(
          id: 0, address: '', lat: start.latitude, lng: start.longitude);
      _reminder.endLocation = EventLocation(
          id: 0, address: '', lat: start.latitude, lng: start.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final bool isSameDay =
        _reminder.startDate!.difference(_reminder.endDate!).inDays == 0;
    final double progress = _reminder.progress.isNaN ? 0 : _reminder.progress;
    final Duration timeRemaining = _reminder.timeLeft(DateTime.now());
    final String daysMess =
        timeRemaining.inDays == 0 ? '' : '${timeRemaining.inDays} day/s, ';
    final String hoursMess =
        '${timeRemaining.inHours - (timeRemaining.inDays * 24)} hours';

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: '0',
        backgroundColor: accent,
        child: const Icon(Icons.check),
        onPressed: () async {},
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 32,
          right: 32,
          top: 70,
          bottom: 20,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              EventPageHeaderWidget(
                title:
                    _reminder.title.isEmpty ? 'Insert title' : _reminder.title,
              ),
              SizedBox(height: resp.hp(5)),
              Text(
                'Event information',
                style: TextStyles.w800(20),
              ),
              SizedBox(height: resp.hp(2.5)),
              ReminderInformationWidget(
                icon: Icons.description_outlined,
                title: 'Description',
                value: _reminder.description.isEmpty
                    ? 'No description'
                    : _reminder.description,
                showSuffixWidget: true,
                onTapEditCallback: () {},
              ),
              ReminderInformationWidget(
                icon: Icons.calendar_today_rounded,
                title: 'Start Date',
                value: _selectedStartDate == null
                    ? 'No date'
                    : '${isSameDay ? 'Today' : getDateFormatted(_selectedStartDate!)} at ${DateFormat('hh:mm a').format(_selectedStartDate!)}',
                showSuffixWidget: true,
                onTapEditCallback: () {},
              ),
              if (_selectedEndDate != null) ...[
                ReminderInformationWidget(
                  icon: Icons.calendar_month_outlined,
                  title: 'End Date',
                  value: _selectedEndDate == null
                      ? 'No date'
                      : '${isSameDay ? 'Today' : getDateFormatted(_selectedEndDate!)} at ${DateFormat('hh:mm a').format(_selectedEndDate!)}',
                  showSuffixWidget: true,
                  onTapEditCallback: () {},
                ),
              ],
              ReminderInformationWidget(
                icon: Icons.timer_outlined,
                title: 'Time remaining',
                value: _selectedEndDate == null || _selectedStartDate == null
                    ? 'No date'
                    : '${timeRemaining.isNegative ? 'Expired ' : ''}$daysMess$hoursMess ${timeRemaining.isNegative ? 'ago' : ''}',
              ),
              // if (reminder.expectedTemp != null)
              //   ReminderInformationWidget(
              //     icon: Icons.location_on_outlined,
              //     title: 'Expected weather:',
              //     extra: WeatherContainer(
              //       temp: reminder.expectedTemp!,
              //     ),
              //   ),
              ReminderInformationWidget(
                icon: Icons.location_on_outlined,
                title: 'Location',
                value: address ?? '',
                extra: Column(
                  children: [
                    if (_reminder.startLocation != null &&
                        _reminder.startLocation!.address != null)
                      ReminderInformationWidget(
                        icon: Icons.location_pin,
                        title: 'Start location',
                        value: _reminder.startLocation!.address,
                      ),
                    if (_reminder.endLocation != null &&
                        _reminder.endLocation!.address != null)
                      ReminderInformationWidget(
                        icon: Icons.location_searching_rounded,
                        title: 'End location',
                        value: _reminder.endLocation!.address,
                      ),
                    if (_reminder.endLocation != null ||
                        _reminder.startLocation != null) ...[
                      MapPreview(
                        height: resp.hp(20),
                        width: resp.width,
                        initialPoint: _reminder.startLocation != null
                            ? GeoPoint(_reminder.startLocation!.lat,
                                _reminder.startLocation!.lng)
                            : const GeoPoint(0, 0),
                        endPoint: _reminder.endLocation != null
                            ? GeoPoint(_reminder.endLocation!.lat,
                                _reminder.endLocation!.lng)
                            : const GeoPoint(0, 0),
                        onAcceptCallback: _onLocationChanged,
                        startAddress: _reminder.startLocation!.address,
                        endAddress: _reminder.endLocation!.address,
                      ),
                    ] else ...[
                      CustomButton(
                        text: 'Add location',
                        color: accent,
                        height: resp.hp(4),
                        width: resp.wp(25),
                        style: TextStyles.w500(14, Colors.white),
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
                title: 'Tags',
                showSuffixWidget: true,
                customSuffixWidget: CustomButton(
                  text: 'Add Tag',
                  color: accent,
                  height: resp.hp(4),
                  width: resp.wp(20),
                  style: TextStyles.w500(14, Colors.white),
                  onTap: () {},
                ),
                extra: TagsList(
                  tagsList: _reminder.tags.map((e) => e.name).toList(),
                  maxTagsToShow: _reminder.tags.length,
                  style: TextStyles.w500(
                    14,
                  ),
                  onLongPressCallback: (index) {
                    final TagModel selectedTag = _reminder.tags[index];

                    CustomAlertDialog(
                      resp: resp,
                      context: context,
                      title: 'Do you want to delete "${selectedTag.name}" tag?',
                      onAcceptCallback: () {
                        setState(() {
                          _reminder.tags.removeAt(index);
                        });
                      },
                    );
                  },
                ),
              ),
              ReminderInformationWidget(
                icon: Icons.list_alt_rounded,
                title: 'Tasks',
                showSuffixWidget: true,
                customSuffixWidget: CustomButton(
                  text: 'Add Task',
                  color: accent,
                  height: resp.hp(4),
                  width: resp.wp(20),
                  style: TextStyles.w500(14, Colors.white),
                  onTap: () {
                    CustomAlertDialog(
                      resp: resp,
                      context: context,
                      title: 'Create new Task',
                      onAcceptCallback: () {
                        setState(() {
                          _reminder.tasks.add(task);
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
                extra: Column(
                  children: List.generate(
                    _reminder.tasks.length,
                    (index) {
                      final TaskModel task = _reminder.tasks[index];
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
                                _reminder.tasks[index].isCompleted = value!;
                              });
                            },
                          ),
                          Expanded(
                            child: Text(
                              task.name,
                              style: TextStyles.w500(14, grey),
                            ),
                          ),
                          IconButton(
                            splashRadius: 20,
                            splashColor: accent.withOpacity(0.1),
                            highlightColor: accent.withOpacity(0.1),
                            icon: const Icon(
                              Icons.remove_circle_outline,
                              color: accent,
                              size: 25,
                            ),
                            onPressed: () {
                              final selectedTask = _reminder.tasks[index];
                              final name = selectedTask.name;
                              CustomAlertDialog(
                                resp: resp,
                                context: context,
                                title: 'Do you want to delete "$name" task?',
                                onAcceptCallback: () {
                                  setState(() {
                                    _reminder.tasks.removeAt(index);
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
              ReminderInformationWidget(
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
              SizedBox(height: resp.hp(5)),
            ],
          ),
        ),
      ),
    );
  }
}
