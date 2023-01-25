import 'package:flutter/material.dart';
import 'package:schedulemanager/data/models/tag_model.dart';

import '../app/config/constants.dart';

class TagsList extends StatelessWidget {
  final void Function(int index)? onLongPressCallback;

  final TextStyle style;
  final List<TagModel> tagsList;
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
          tagsList.length.clamp(0, maxTagsToShow ?? tagsList.length), (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 5),
          child: InkWell(
            borderRadius: BorderRadius.circular(12.5),
            radius: 5,
            onLongPress: () {
              if (onLongPressCallback != null) onLongPressCallback!(index);
            },
            child: Chip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.5),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              backgroundColor: accent,
              label: Text(
                '#${tagsList[index].name.replaceAll(RegExp(r'\s+'), '')}',
                style: style,
              ),
            ),
          ),
        );
      }),
    );
  }
}
