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
  late DateTime? _selectedStartDate;
  late DateTime? _selectedEndDate;

  @override
  void initState() {
    super.initState();
    if (_hasDate) {
      _selectedEndDate = widget.reminder!.endDate.toDate();
      _selectedStartDate = widget.reminder!.startDate.toDate();
    } else {
      _selectedEndDate = null;
      _selectedStartDate = null;
    }
    address = null;
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

  bool get _hasDate => widget.reminder!.uid.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final ReminderService service = Provider.of<ReminderService>(context);

    final bool isSameDay =
        _selectedEndDate == null || _selectedStartDate == null
            ? false
            : _selectedStartDate!.difference(_selectedEndDate!).inDays == 0;
    final double progress =
        widget.reminder!.progress.isNaN ? 0 : widget.reminder!.progress;
    final Duration timeRemaining = widget.reminder!.timeLeft(DateTime.now());
    final String daysMess =
        timeRemaining.inDays == 0 ? '' : '${timeRemaining.inDays} day/s, ';
    final String hoursMess =
        '${timeRemaining.inHours - (timeRemaining.inDays * 24)} hours';

    return Scaffold(
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '1',
            backgroundColor: Colors.grey[100],
            elevation: 0.5,
            child: const Icon(Icons.mode, color: accent),
            onPressed: () async {
              CustomAlertDialog(
                resp: resp,
                context: context,
                title: 'Modify Reminder',
                onAcceptCallback: () {},
                customBody: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: resp.hp(1)),
                    Text(
                      'Title',
                      style: TextStyles.w600(resp.sp14),
                    ),
                    SizedBox(height: resp.hp(1)),
                    CustomFormField(
                      labelText: 'Title',
                      hintText: 'My title',
                      icon: Icons.my_library_books_outlined,
                      onChanged: (value) {
                        widget.reminder!.title = value;
                      },
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
                      onChanged: (value) {
                        widget.reminder!.description = value;
                      },
                    ),
                  ],
                ),
              );
            },
          ),
          SizedBox(width: resp.wp(1.5)),
          FloatingActionButton(
            heroTag: '0',
            backgroundColor: accent,
            child: const Icon(Icons.check),
            onPressed: () async {
              final idIsEmpty = widget.reminder!.uid.isEmpty;
              if (service.isValidToUpload(widget.reminder!)) {
                await (idIsEmpty
                        ? service.create(widget.reminder!.toMap())
                        : service.update(widget.reminder!.toMap()))
                    .whenComplete(
                  () {
                    Navigator.pop(context);
                  },
                );
              }
            },
          ),
        ],
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
                            value: _selectedStartDate == null
                                ? 'No date'
                                : '${isSameDay ? 'Today' : getDateFormatted(_selectedStartDate!)} at ${DateFormat('hh:mm a').format(_selectedStartDate!)}',
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
                            // ? Start date
                            CustomDateTimePicker(
                              context: context,
                              firstDate: _hasDate
                                  ? DateTime(DateTime.now().year - 3)
                                  : DateTime.now(),
                              endDate: DateTime(DateTime.now().year + 3),
                              startDate: DateTime.now(),
                              onAcceptCallback: (date) {
                                setState(() {
                                  _selectedStartDate = date;
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
                            value: _selectedEndDate == null
                                ? 'No date'
                                : '${isSameDay ? 'Today' : getDateFormatted(_selectedEndDate!)} at ${DateFormat('hh:mm a').format(_selectedEndDate!)}',
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
                            // ? End date
                            CustomDateTimePicker(
                              context: context,
                              startDate: _selectedStartDate ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              endDate: DateTime(DateTime.now().year + 3),
                              onAcceptCallback: (date) {
                                setState(() {
                                  _selectedEndDate = date;
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
                    value: _selectedEndDate == null ||
                            _selectedStartDate == null
                        ? 'No date'
                        : '${timeRemaining.isNegative ? 'Expired ' : ''}$daysMess$hoursMess ${timeRemaining.isNegative ? 'ago' : ''}',
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
                    value: '${progress.toStringAsFixed(2)}%',
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
          ],
        ),
      ),
    );
  }
}
