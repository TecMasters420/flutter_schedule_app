import 'package:flutter/material.dart';
import 'package:schedulemanager/app/config/constants.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/app/utils/text_styles.dart';
import 'package:schedulemanager/widgets/custom_back_button.dart';

class EventPageHeaderWidget extends StatelessWidget {
  final String title;
  const EventPageHeaderWidget({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: CustomBackButton()),
        Expanded(
          flex: 8,
          child: Container(
            decoration: BoxDecoration(
              color: containerBg,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(child: Text(title, style: TextStyles.w700(35))),
          ),
        ),
        Expanded(
          child: IconButton(
            icon: const Icon(
              Icons.edit,
              color: accent,
            ),
            splashRadius: 20,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.zero,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
