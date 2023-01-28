import 'package:flutter/material.dart';
import 'package:schedulemanager/widgets/responsive_container_widget.dart';

import '../app/config/constants.dart';
import '../app/utils/text_styles.dart';
import 'custom_back_button.dart';

class CustomHeaderWidget extends StatelessWidget {
  final String title;
  final double titleSize;
  final Widget? suffixWidget;
  const CustomHeaderWidget({
    super.key,
    required this.title,
    this.suffixWidget,
    this.titleSize = 25,
  });

  @override
  Widget build(BuildContext context) {
    final styles = TextStyles.of(context);

    return Row(
      children: [
        const Expanded(
          child: Align(
            alignment: Alignment.centerLeft,
            child: CustomBackButton(),
          ),
        ),
        Expanded(
          flex: 8,
          child: ResponsiveContainerWidget(
            customColor: darkAccent,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Center(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: styles.w700(titleSize, Colors.white),
              ),
            ),
          ),
        ),
        Expanded(
          child: suffixWidget ?? const SizedBox(),
        ),
      ],
    );
  }
}
