import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import '../../data/models/event_location_model.dart';
import '../map_page/map_page.dart';
import 'widgets/custom_alert_with_calendart.dart';
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
import '../../widgets/custom_back_button.dart';

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
  late DateTime? _tempStartDate;
  late DateTime? _tempEndDate;

  @override
  void initState() {
    super.initState();
    _reminder = widget.reminder!;
    _tempStartDate = null;
    _tempEndDate = null;
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
                      style: TextStyles.w600(14),
                    ),
                    SizedBox(height: resp.hp(1)),
                    CustomFormField(
                      labelText: 'Title',
                      hintText: 'My title',
                      icon: Icons.my_library_books_outlined,
                      onChanged: (value) {
                        _reminder.title = value;
                      },
                    ),
                    SizedBox(height: resp.hp(1)),
                    Text(
                      'Description',
                      style: TextStyles.w600(14),
                    ),
                    SizedBox(height: resp.hp(1)),
                    CustomFormField(
                      labelText: 'Description',
                      hintText: 'My description',
                      icon: Icons.mode_edit_outline_outlined,
                      onChanged: (value) {
                        _reminder.description = value;
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
              // final idIsEmpty = false;
              // if (reminderService.isValidToUpload(_reminder)) {
              //   CustomAlertDialog(
              //     resp: resp,
              //     dismissible: false,
              //     context: context,
              //     onAcceptCallback: () {},
              //     showButtons: false,
              //     title: 'Adding reminder...',
              //     customBody: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         const CustomCircularProgress(color: accent),
              //         SizedBox(height: resp.hp(2)),
              //         Text('Wait a bit while it saves',
              //             style: TextStyles.w500(16))
              //       ],
              //     ),
              //   );
              //   await (idIsEmpty
              //           ? reminderService.createData(_reminder.toMap())
              //           : reminderService.updateData(_reminder.toMap()))
              //       .whenComplete(
              //     () {
              //       Navigator.pop(context);
              //       Navigator.pop(context);
              //     },
              //   );
              // } else {
              //   CustomAlertDialog(
              //     resp: resp,
              //     dismissible: true,
              //     context: context,
              //     onAcceptCallback: () {},
              //     showButtons: false,
              //     title: 'Can not save!',
              //     customBody: Column(
              //       mainAxisSize: MainAxisSize.min,
              //       children: [
              //         Icon(Icons.block_rounded,
              //             color: Colors.red[200], size: 45),
              //         SizedBox(height: resp.hp(2)),
              //         Text('Review the entered data.',
              //             style: TextStyles.w500(16))
              //       ],
              //     ),
              //   );
              // }
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
                      _reminder.title.isEmpty
                          ? 'Insert title'
                          : _reminder.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyles.w700(35),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Text(
                          _reminder.description.isEmpty
                              ? 'Insert description'
                              : _reminder.description,
                          maxLines: 20,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyles.w500(14),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: resp.hp(2.5)),
                  Text(
                    'Reminder information:',
                    style: TextStyles.w800(16),
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
                          icon: const Icon(
                            Icons.mode,
                            color: lightGrey,
                            size: 25,
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
                                  _reminder.startDate = _tempStartDate!;
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
                            icon: const Icon(
                              Icons.mode,
                              color: lightGrey,
                              size: 25,
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
                                    _reminder.endDate = _tempEndDate!;
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
                            color: lightGrey.withOpacity(0.25),
                            height: resp.hp(5),
                            width: resp.width,
                            style: TextStyles.w500(16),
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
                          title:
                              'Do you want to delete "${selectedTag.name}" tag?',
                          onAcceptCallback: () {
                            setState(() {
                              _reminder.tags.removeAt(index);
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
                        style: TextStyles.w500(14),
                        prefixWidget: const Icon(
                          Icons.add,
                          size: 16,
                          color: accent,
                        ),
                        onTap: () {
                          CustomAlertDialog(
                            resp: resp,
                            context: context,
                            title: 'Create new Tag',
                            onAcceptCallback: () {
                              setState(() {
                                _reminder.tags.add(tag);
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
                                splashColor: Colors.red.withOpacity(0.3),
                                highlightColor: Colors.red.withOpacity(0.25),
                                icon: const Icon(
                                  Icons.remove_circle_outline,
                                  color: lightGrey,
                                  size: 25,
                                ),
                                onPressed: () {
                                  final TaskModel selectedTask =
                                      _reminder.tasks[index];
                                  CustomAlertDialog(
                                    resp: resp,
                                    context: context,
                                    title:
                                        'Do you want to delete "${selectedTask.name}" task?',
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(),
                      CustomButton(
                        text: 'Add Task',
                        color: lightGrey.withOpacity(0.25),
                        height: resp.hp(4),
                        width: resp.wp(30),
                        style: TextStyles.w500(14),
                        prefixWidget: const Icon(
                          Icons.add,
                          size: 16,
                          color: accent,
                        ),
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
