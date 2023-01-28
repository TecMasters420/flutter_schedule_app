import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:schedulemanager/app/utils/responsive_util.dart';
import 'package:schedulemanager/modules/event_details_creation/controller/expandible_widget_controller.dart';

import '../../../app/config/constants.dart';
import '../../../app/utils/text_styles.dart';

class EventExpandibleDetailsWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final Widget body;
  final Color iconColor;
  const EventExpandibleDetailsWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.body,
    this.value,
    this.iconColor = grey,
  });

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);

    return GetBuilder(
      init: ExpandibleWidgetController(),
      tag: title,
      builder: (controller) {
        return ExpansionPanelList(
          animationDuration: const Duration(milliseconds: 200),
          elevation: 0,
          dividerColor: Colors.transparent,
          expandedHeaderPadding: EdgeInsets.zero,
          children: [
            ExpansionPanel(
              backgroundColor: Colors.transparent,
              isExpanded: controller.isExpanded.value,
              canTapOnHeader: true,
              headerBuilder: (context, isExpanded) {
                return ListTile(
                  dense: false,
                  minVerticalPadding: 0,
                  minLeadingWidth: 0,
                  contentPadding: EdgeInsets.zero,
                  trailing: const Icon(Icons.edit, size: 25, color: blueAccent),
                  title: Row(
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
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: body,
              ),
            ),
          ],
          expansionCallback: (panelIndex, isExpanded) {
            controller.changeState(!isExpanded);
            controller.update();
          },
        );
      },
    );
  }
}
