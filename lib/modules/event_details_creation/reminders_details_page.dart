// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:schedulemanager/modules/event_details_creation/controller/events_details_creation_controller.dart';
// import 'package:schedulemanager/modules/event_details_creation/widgets/weather_container.dart';
// import 'package:schedulemanager/widgets/custom_header_widget.dart';
// import 'package:schedulemanager/widgets/custom_text_button_widget.dart';
// import 'package:schedulemanager/widgets/responsive_container_widget.dart';
// import '../../data/models/event_location_model.dart';
// import '../map_page/map_page.dart';
// import '../../app/config/constants.dart';
// import '../../data/models/event_model.dart';
// import '../../data/models/tag_model.dart';
// import '../../data/models/task_model.dart';
// import '../../app/services/base_repository.dart';
// import '../../app/utils/responsive_util.dart';
// import '../../widgets/custom_alert_dialog.dart';
// import '../../widgets/custom_button.dart';
// import '../../widgets/custom_form_field.dart';
// import '../../widgets/map_preview.dart';
// import '../../widgets/progress_bar.dart';
// import '../../widgets/reminder_information_widget.dart';
// import '../../widgets/tags_list.dart';

// import '../../app/utils/text_styles.dart';

// class EventDetailsCreationPage extends StatefulWidget {
//   const EventDetailsCreationPage({super.key});

//   @override
//   State<EventDetailsCreationPage> createState() =>
//       _EventDetailsCreationPageState();
// }

// class _EventDetailsCreationPageState extends State<EventDetailsCreationPage> {
//   late final EventModel _event;
//   late TagModel tag;
//   late TaskModel task;
//   late String? address;
//   late DateTime? _selectedStartDate;
//   late DateTime? _selectedEndDate;
//   late final EventsDetailsCreationController controller;

//   @override
//   void initState() {
//     super.initState();
//     controller = Get.find();
//     _event = controller.event.value!;
//     address = null;
//     tag = TagModel(name: '');
//     task = TaskModel(name: '', isCompleted: false);
//   }

//   String getDateFormatted(DateTime date) {
//     final formattedDate =
//         DateFormat(DateFormat.YEAR_MONTH_DAY, 'en_US').format(date.toUtc());
//     return formattedDate;
//   }

//   void _onLocationChanged(final LatLng start, final String? startAddress,
//       final LatLng end, final String? endAddress, List<LatLng>? points) {
//     setState(() {
//       _event.startLocation = EventLocationModel(
//           id: 0, address: '', lat: start.latitude, lng: start.longitude);
//       _event.endLocation = EventLocationModel(
//           id: 0, address: '', lat: start.latitude, lng: start.longitude);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final ResponsiveUtil resp = ResponsiveUtil.of(context);
//     final bool isSameDay =
//         _event.startDate.difference(_event.endDate).inDays == 0;
//     final double progress = _event.progress.isNaN ? 0 : _event.progress;
//     final Duration timeRemaining = _event.timeLeft(DateTime.now());
//     final String daysMess =
//         timeRemaining.inDays == 0 ? '' : '${timeRemaining.inDays} day/s, ';
//     final String hoursMess =
//         '${timeRemaining.inHours - (timeRemaining.inDays * 24)} hours';

//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         heroTag: '0',
//         backgroundColor: accent,
//         child: const Icon(Icons.check),
//         onPressed: () async {},
//       ),
//       body: Padding(
//         padding: const EdgeInsets.only(
//           left: 32,
//           right: 32,
//           top: 70,
//           bottom: 20,
//         ),
//         child: SingleChildScrollView(
//           clipBehavior: Clip.none,
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               CustomHeaderWidget(
//                 title: _event.title.isEmpty ? 'Insert title' : _event.title,
//                 suffixWidget: IconButton(
//                   icon: const Icon(
//                     Icons.edit,
//                     color: accent,
//                   ),
//                   splashRadius: 20,
//                   alignment: Alignment.centerRight,
//                   padding: EdgeInsets.zero,
//                   onPressed: () {},
//                 ),
//               ),
//               SizedBox(height: resp.hp(2.5)),
//               Text(
//                 'Event information',
//                 style: TextStyles.w800(20),
//               ),
//               SizedBox(height: resp.hp(2.5)),
//               ResponsiveContainerWidget(
//                 child: Column(
//                   children: [
//                     SizedBox(height: resp.hp(2.5)),
//                     EventDetailsWidget(
//                       icon: Icons.description_outlined,
//                       title: 'Description',
//                       value: _event.description.isEmpty
//                           ? 'No description'
//                           : _event.description,
//                       showSuffixWidget: true,
//                       onTapEditCallback: () {},
//                     ),
//                     EventDetailsWidget(
//                       icon: Icons.tag_rounded,
//                       title: 'Tags',
//                       showSuffixWidget: true,
//                       customSuffixWidget: CustomTextButtonWidget(
//                         title: 'Add',
//                         onTap: () {},
//                       ),
//                       extra: TagsList(
//                         tagsList: _event.tags,
//                         maxTagsToShow: _event.tags.length,
//                         style: TextStyles.w500(
//                           14,
//                           Colors.white,
//                         ),
//                         onLongPressCallback: (index) {
//                           final TagModel selectedTag = _event.tags[index];

//                           CustomAlertDialog(
//                             resp: resp,
//                             context: context,
//                             title:
//                                 'Do you want to delete "${selectedTag.name}" tag?',
//                             onAcceptCallback: () {
//                               setState(() {
//                                 _event.tags.removeAt(index);
//                               });
//                             },
//                           );
//                         },
//                       ),
//                     ),
//                     EventDetailsWidget(
//                       icon: Icons.list_alt_rounded,
//                       title: 'Tasks',
//                       showSuffixWidget: true,
//                       customSuffixWidget: CustomTextButtonWidget(
//                         title: 'Add',
//                         onTap: () {
//                           CustomAlertDialog(
//                             resp: resp,
//                             context: context,
//                             title: 'Create new Task',
//                             onAcceptCallback: () {
//                               setState(() {
//                                 _event.tasks.add(task);
//                                 task = TaskModel(name: '', isCompleted: false);
//                               });
//                             },
//                             customBody: CustomFormField(
//                               icon: Icons.abc,
//                               onChanged: (value) {
//                                 setState(() {
//                                   task.name = value;
//                                 });
//                               },
//                             ),
//                           );
//                         },
//                       ),
//                       extra: Column(
//                         children: List.generate(
//                           _event.tasks.length,
//                           (index) {
//                             final TaskModel task = _event.tasks[index];
//                             return Row(
//                               children: [
//                                 Checkbox(
//                                   activeColor: accent,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(10),
//                                   ),
//                                   value: task.isCompleted,
//                                   onChanged: (value) {
//                                     setState(() {
//                                       _event.tasks[index].isCompleted = value!;
//                                     });
//                                   },
//                                 ),
//                                 Expanded(
//                                   child: Text(
//                                     task.name,
//                                     style: TextStyles.w500(14, grey).copyWith(
//                                       decorationColor: grey,
//                                       decoration:
//                                           _event.tasks[index].isCompleted
//                                               ? TextDecoration.lineThrough
//                                               : null,
//                                     ),
//                                   ),
//                                 ),
//                                 IconButton(
//                                   splashRadius: 20,
//                                   splashColor: red.withOpacity(0.1),
//                                   highlightColor: red.withOpacity(0.1),
//                                   icon: const Icon(
//                                     Icons.remove_circle_outline,
//                                     color: lightGrey,
//                                     size: 25,
//                                   ),
//                                   onPressed: () {
//                                     final selectedTask = _event.tasks[index];
//                                     final name = selectedTask.name;
//                                     CustomAlertDialog(
//                                       resp: resp,
//                                       context: context,
//                                       title:
//                                           'Do you want to delete "$name" task?',
//                                       onAcceptCallback: () {
//                                         setState(() {
//                                           _event.tasks.removeAt(index);
//                                         });
//                                       },
//                                     );
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                     EventDetailsWidget(
//                       icon: Icons.bar_chart_rounded,
//                       title: 'Progress',
//                       value: '${progress.toStringAsFixed(2)}%',
//                       extra: Column(
//                         children: [
//                           SizedBox(height: resp.hp(1)),
//                           ProgressBar(
//                             percent: progress,
//                             height: resp.hp(2.5),
//                             width: resp.wp(70),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: resp.hp(2.5)),
//               Text(
//                 'Event Date',
//                 style: TextStyles.w800(18),
//               ),
//               SizedBox(height: resp.hp(2.5)),
//               ResponsiveContainerWidget(
//                 child: Column(
//                   children: [
//                     SizedBox(height: resp.hp(2.5)),
//                     EventDetailsWidget(
//                       icon: Icons.calendar_today_rounded,
//                       title: 'Start Date',
//                       value: _selectedStartDate == null
//                           ? 'No date'
//                           : '${isSameDay ? 'Today' : getDateFormatted(_selectedStartDate!)} at ${DateFormat('hh:mm a').format(_selectedStartDate!)}',
//                       showSuffixWidget: true,
//                       onTapEditCallback: () {},
//                     ),
//                     if (_selectedEndDate != null) ...[
//                       EventDetailsWidget(
//                         icon: Icons.calendar_month_outlined,
//                         title: 'End Date',
//                         value: _selectedEndDate == null
//                             ? 'No date'
//                             : '${isSameDay ? 'Today' : getDateFormatted(_selectedEndDate!)} at ${DateFormat('hh:mm a').format(_selectedEndDate!)}',
//                         showSuffixWidget: true,
//                         onTapEditCallback: () {},
//                       ),
//                     ],
//                     EventDetailsWidget(
//                       icon: Icons.timer_outlined,
//                       title: 'Time remaining',
//                       value: _selectedEndDate == null ||
//                               _selectedStartDate == null
//                           ? 'No date'
//                           : '${timeRemaining.isNegative ? 'Expired ' : ''}$daysMess$hoursMess ${timeRemaining.isNegative ? 'ago' : ''}',
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: resp.hp(2.5)),
//               Text(
//                 'Event Weather',
//                 style: TextStyles.w800(18),
//               ),
//               SizedBox(height: resp.hp(2.5)),
//               // if (reminder.expectedTemp != null)
//               ResponsiveContainerWidget(
//                 child: Column(
//                   children: [
//                     SizedBox(height: resp.hp(2.5)),
//                     const EventDetailsWidget(
//                       icon: Icons.water_drop_outlined,
//                       title: 'Expected weather',
//                       extra: WeatherContainer(
//                         temp: 30,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: resp.hp(2.5)),
//               Text(
//                 'Event Location',
//                 style: TextStyles.w800(18),
//               ),
//               SizedBox(height: resp.hp(2.5)),
//               ResponsiveContainerWidget(
//                 child: Column(
//                   children: [
//                     SizedBox(height: resp.hp(2.5)),
//                     EventDetailsWidget(
//                       icon: Icons.location_on_outlined,
//                       title: 'Location',
//                       value: address,
//                       extra: Column(
//                         children: [
//                           if (_event.startLocation != null &&
//                               _event.startLocation!.address != null)
//                             EventDetailsWidget(
//                               icon: Icons.location_pin,
//                               title: 'Start location',
//                               value: _event.startLocation!.address,
//                             ),
//                           if (_event.endLocation != null &&
//                               _event.endLocation!.address != null)
//                             EventDetailsWidget(
//                               icon: Icons.location_searching_rounded,
//                               title: 'End location',
//                               value: _event.endLocation!.address,
//                             ),
//                           if (_event.endLocation != null ||
//                               _event.startLocation != null) ...[
//                             MapPreview(
//                               height: resp.hp(20),
//                               width: resp.width,
//                               initialPoint: _event.startLocation != null
//                                   ? GeoPoint(_event.startLocation!.lat,
//                                       _event.startLocation!.lng)
//                                   : const GeoPoint(0, 0),
//                               endPoint: _event.endLocation != null
//                                   ? GeoPoint(_event.endLocation!.lat,
//                                       _event.endLocation!.lng)
//                                   : const GeoPoint(0, 0),
//                               onAcceptCallback: _onLocationChanged,
//                               startAddress: _event.startLocation!.address,
//                               endAddress: _event.endLocation!.address,
//                             ),
//                           ] else ...[
//                             CustomButton(
//                               text: 'Add location',
//                               color: accent,
//                               style: TextStyles.w700(14, Colors.white),
//                               onTap: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => MapPage(
//                                       onAcceptCallback: _onLocationChanged,
//                                     ),
//                                   ),
//                                 );
//                               },
//                             )
//                           ]
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
