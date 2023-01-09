import 'package:flutter/material.dart';

import '../app/config/constants.dart';
import '../app/utils/responsive_util.dart';
import '../app/utils/text_styles.dart';

class ReminderInformationWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final Widget? extra;
  final bool showSuffixWidget;
  final VoidCallback? onTapEditCallback;
  final Widget? customSuffixWidget;
  const ReminderInformationWidget({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    this.extra,
    this.showSuffixWidget = false,
    this.onTapEditCallback,
    this.customSuffixWidget,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    icon,
                    color: lightGrey,
                    size: 25,
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
                          // SizedBox(height: resp.hp(1)),
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
                  IconButton(
                    style: IconButton.styleFrom(padding: EdgeInsets.zero),
                    splashRadius: 20,
                    splashColor: accent.withOpacity(0.3),
                    highlightColor: accent.withOpacity(0.25),
                    icon: const Icon(
                      Icons.mode,
                      color: accent,
                      size: 25,
                    ),
                    onPressed: onTapEditCallback,
                  ),
          ],
        ),
        SizedBox(height: resp.hp(2.5)),
      ],
    );
  }
}
