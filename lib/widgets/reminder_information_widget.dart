import 'package:flutter/material.dart';
import 'package:schedulemanager/widgets/custom_icon_buttton_widget.dart';

import '../app/config/constants.dart';
import '../app/utils/responsive_util.dart';
import '../app/utils/text_styles.dart';

class EventDetailsWidget extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String? value;
  final Widget? extra;
  final bool showSuffixWidget;
  final VoidCallback? onTapEditCallback;
  final Widget? customSuffixWidget;
  const EventDetailsWidget({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.extra,
    this.onTapEditCallback,
    this.customSuffixWidget,
    this.showSuffixWidget = false,
    this.iconColor = grey,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: iconColor.withOpacity(0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      icon,
                      color: iconColor,
                      size: 25,
                    ),
                  ),
                  SizedBox(width: resp.wp(5)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyles.w700(14),
                        ),
                        if (value != null)
                          Text(
                            value!,
                            style: TextStyles.w500(12, grey),
                          ),
                        if (extra != null) ...[
                          SizedBox(height: resp.hp(1)),
                          extra!,
                        ]
                      ],
                    ),
                  )
                ],
              ),
            ),
            if (showSuffixWidget)
              customSuffixWidget ??
                  CustomIconButtonWidget(
                    color: blueAccent,
                    icon: Icons.edit,
                    onTapCallback: onTapEditCallback ?? () {},
                  )
          ],
        ),
        SizedBox(height: resp.hp(2.5)),
      ],
    );
  }
}
