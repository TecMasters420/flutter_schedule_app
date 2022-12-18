import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:schedulemanager/presentation/pages/map_page/map_page.dart';
import 'package:schedulemanager/presentation/pages/reminder_details_page/widgets/custom_alert_with_calendart.dart';
import '../../../app/config/constants.dart';
import '../../../data/models/reminder_model.dart';
import '../../../data/models/tag_model.dart';
import '../../../data/models/task_model.dart';
import '../../../app/services/base_service.dart';
import '../../../app/utils/responsive_util.dart';
import '../../controllers/reminders_controller.dart';
import '../../widgets/custom_alert_dialog.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_circular_progress.dart';
import '../../widgets/custom_form_field.dart';
import '../../widgets/map_preview.dart';
import '../../widgets/progress_bar.dart';
import '../../widgets/reminder_information_widget.dart';
import '../../widgets/tags_list.dart';

import '../../../app/utils/text_styles.dart';
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
  late DateTime? _tempStartDate;
  late DateTime? _tempEndDate;

  @override
  void initState() {
    super.initState();
    _tempStartDate = null;
    _tempEndDate = null;
    // if (_hasDate) {
    //   _selectedEndDate = reminder.endDate.toDate();
    //   _selectedStartDate = reminder.startDate.toDate();
    // } else {
    //   _selectedEndDate = null;
    //   _selectedStartDate = null;
    // }
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
      // reminder.startLocation =
      //     GeoPoint(start.latitude, start.longitude);
      // reminder.endLocation = GeoPoint(end.latitude, end.longitude);
      // reminder.startLocationAddress = startAddress;
      // reminder.endLocationAddress = endAddress;
    });
  }

  // bool get _hasDate => reminder.uid.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    final RemindersController reminderService = Get.find<RemindersController>();
    final reminder = widget.reminder!;
    final bool isSameDay =
        reminder.startDate.difference(reminder.endDate).inDays == 0;
    final double progress = reminder.progress.isNaN ? 0 : reminder.progress;
    final Duration timeRemaining = reminder.timeLeft(DateTime.now());
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
                        reminder.title = value;
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
                        reminder.description = value;
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
              // final idIsEmpty = reminder.uid.isEmpty;
              final idIsEmpty = false;
              if (reminderService.isValidToUpload(reminder)) {
                CustomAlertDialog(
                  resp: resp,
                  dismissible: false,
                  context: context,
                  onAcceptCallback: () {},
                  showButtons: false,
                  title: 'Adding reminder...',
                  customBody: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const CustomCircularProgress(color: accent),
                      SizedBox(height: resp.hp(2)),
                      Text('Wait a bit while it saves',
                          style: TextStyles.w500(resp.sp16))
                    ],
                  ),
                );
                await (idIsEmpty
                        ? reminderService.createData(reminder.toMap())
                        : reminderService.updateData(reminder.toMap()))
                    .whenComplete(
                  () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                );
              } else {
                CustomAlertDialog(
                  resp: resp,
                  dismissible: true,
                  context: context,
                  onAcceptCallback: () {},
                  showButtons: false,
                  title: 'Can not save!',
                  customBody: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.block_rounded,
                          color: Colors.red[200], size: resp.sp40),
                      SizedBox(height: resp.hp(2)),
                      Text('Review the entered data.',
                          style: TextStyles.w500(resp.sp16))
                    ],
                  ),
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
                      reminder.title.isEmpty ? 'Insert title' : reminder.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.w700(resp.sp30),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          reminder.description.isEmpty
                              ? 'Insert description'
                              : reminder.description,
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.w500(resp.sp14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
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
                            CustomAlertDialog(
                              resp: resp,
                              context: context,
                              dismissible: false,
                              title: 'Select start date',
                              onAcceptCallback: () {
                                setState(() {
                                  reminder.startDate = _tempStartDate!;
                                  _selectedStartDate = _tempStartDate;
                                });
                              },
                              customBody: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ScrolleableCalendarWithHour(
                                    endDate: DateTime(DateTime.now().year + 3),
                                    firstDate: DateTime.now(),
                                    onChangesInDate: (date) {
                                      _tempStartDate = date;
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  if (_selectedStartDate != null) ...[
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
                              CustomAlertDialog(
                                resp: resp,
                                context: context,
                                dismissible: false,
                                title: 'Select end date',
                                onAcceptCallback: () {
                                  setState(() {
                                    reminder.endDate = _tempEndDate!;
                                    _selectedEndDate = _tempEndDate;
                                  });
                                },
                                customBody: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ScrolleableCalendarWithHour(
                                      endDate:
                                          DateTime(DateTime.now().year + 3),
                                      firstDate: _selectedStartDate!,
                                      onChangesInDate: (date) {
                                        _tempEndDate = date;
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                  ReminderInformationWidget(
                    icon: Icons.timer,
                    title: 'Time remaining:',
                    value: _selectedEndDate == null ||
                            _selectedStartDate == null
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
                    title: 'Location:',
                    value: address ?? '',
                    extra: Column(
                      children: [
                        if (reminder.startLocation != null &&
                            reminder.startLocation!.address != null)
                          ReminderInformationWidget(
                            icon: Icons.location_pin,
                            title: 'Start location',
                            value: reminder.startLocation!.address,
                          ),
                        if (reminder.endLocation != null &&
                            reminder.endLocation!.address != null)
                          ReminderInformationWidget(
                            icon: Icons.location_searching_rounded,
                            title: 'End location',
                            value: reminder.endLocation!.address,
                          ),
                        if (reminder.endLocation != null ||
                            reminder.startLocation != null) ...[
                          MapPreview(
                            height: resp.hp(20),
                            width: resp.width,
                            initialPoint: reminder.startLocation != null
                                ? GeoPoint(reminder.startLocation!.lat,
                                    reminder.startLocation!.lng)
                                : const GeoPoint(0, 0),
                            endPoint: reminder.endLocation != null
                                ? GeoPoint(reminder.endLocation!.lat,
                                    reminder.endLocation!.lng)
                                : const GeoPoint(0, 0),
                            onAcceptCallback: _onLocationChanged,
                            startAddress: reminder.startLocation!.address,
                            endAddress: reminder.endLocation!.address,
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
                      tagsList: reminder.tags.map((e) => e.name).toList(),
                      maxTagsToShow: reminder.tags.length,
                      style: TextStyles.w500(
                        resp.sp14,
                      ),
                      onLongPressCallback: (index) {
                        final TagModel selectedTag = reminder.tags[index];

                        CustomAlertDialog(
                          resp: resp,
                          context: context,
                          title:
                              'Do you want to delete "${selectedTag.name}" tag?',
                          onAcceptCallback: () {
                            setState(() {
                              reminder.tags.removeAt(index);
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
                                reminder.tags.add(tag);
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
                        reminder.tasks.length,
                        (index) {
                          final TaskModel task = reminder.tasks[index];
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
                                    reminder.tasks[index].isCompleted = value!;
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
                                      reminder.tasks[index];
                                  CustomAlertDialog(
                                    resp: resp,
                                    context: context,
                                    title:
                                        'Do you want to delete "${selectedTask.name}" task?',
                                    onAcceptCallback: () {
                                      setState(() {
                                        reminder.tasks.removeAt(index);
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
                                reminder.tasks.add(task);
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
