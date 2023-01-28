import 'package:flutter/material.dart';
import 'package:schedulemanager/data/models/tag_model.dart';
import '../app/utils/text_styles.dart';

class TagsList extends StatelessWidget {
  final void Function(int index)? onLongPressCallback;

  final List<TagModel> tagsList;
  final int? maxTagsToShow;
  const TagsList({
    super.key,
    required this.tagsList,
    this.maxTagsToShow,
    this.onLongPressCallback,
  });

  @override
  Widget build(BuildContext context) {
    final styles = TextStyles.of(context);
    if (tagsList.isEmpty) return const SizedBox();
    return Wrap(
      alignment: WrapAlignment.start,
      direction: Axis.horizontal,
      children: List.generate(
          tagsList.length.clamp(0, maxTagsToShow ?? tagsList.length), (index) {
        return Padding(
          padding: const EdgeInsets.only(right: 5),
          child: GestureDetector(
            onLongPress: () {
              if (onLongPressCallback != null) onLongPressCallback!(index);
            },
            child: Chip(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.5),
                side: const BorderSide(width: 0),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              backgroundColor: Colors.black,
              clipBehavior: Clip.none,
              label: Text(
                '#${tagsList[index].name.replaceAll(RegExp(r'\s+'), '')}',
                style: styles.w700(14, styles.chipsColor),
              ),
            ),
          ),
        );
      }),
    );
  }
}
