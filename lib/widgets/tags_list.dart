import 'package:flutter/material.dart';

import '../constants/constants.dart';

class TagsList extends StatelessWidget {
  final void Function(int index)? onLongPressCallback;

  final TextStyle style;
  final List<String> tagsList;
  final int? maxTagsToShow;
  const TagsList({
    super.key,
    required this.style,
    required this.tagsList,
    this.maxTagsToShow,
    this.onLongPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      children: List.generate(
        tagsList.length.clamp(0, maxTagsToShow ?? tagsList.length),
        (index) => Padding(
          padding: EdgeInsets.only(left: index == 0 ? 0 : 5),
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            radius: 5,
            onLongPress: () {
              if (onLongPressCallback != null) onLongPressCallback!(index);
            },
            child: Chip(
              padding: EdgeInsets.zero,
              backgroundColor: lightGrey.withOpacity(0.2),
              //     _coloredTypes.values.elementAt(index),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              label: Text(tagsList[index], style: style),
            ),
          ),
        ),
      ),
    );
  }
}
