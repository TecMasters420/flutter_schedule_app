import 'package:flutter/material.dart';
import '../../../app/utils/responsive_util.dart';
import '../../../widgets/custom_button.dart';

import '../../../app/config/constants.dart';
import '../../../data/models/reminder_model.dart';
import '../../../app/utils/text_styles.dart';
import '../../../widgets/custom_form_field.dart';

class CreateReminderForm extends StatelessWidget {
  final void Function(ReminderModel reminder) onAcceptCallback;
  final ReminderModel reminder;
  late final TextEditingController _titleController;
  late final TextEditingController _desController;

  CreateReminderForm({
    super.key,
    required this.onAcceptCallback,
    required this.reminder,
  }) {
    _titleController = TextEditingController(text: reminder.title);
    _desController = TextEditingController(text: reminder.description);
  }

  @override
  Widget build(BuildContext context) {
    final ResponsiveUtil resp = ResponsiveUtil.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(height: resp.hp(1)),
        Text(
          'Title',
          style: TextStyles.w600(14),
        ),
        SizedBox(height: resp.hp(1)),
        CustomFormField(
          controller: _titleController,
          labelText: 'Title',
          hintText: 'My title',
          icon: Icons.my_library_books_outlined,
          onChanged: (value) {
            reminder.title = value;
          },
        ),
        SizedBox(height: resp.hp(1)),
        Text(
          'Description',
          style: TextStyles.w600(14),
        ),
        SizedBox(height: resp.hp(1)),
        CustomFormField(
          controller: _desController,
          labelText: 'Description',
          hintText: 'My description',
          icon: Icons.mode_edit_outline_outlined,
          onChanged: (value) {
            reminder.description = value;
          },
        ),
        SizedBox(height: resp.hp(1)),
        CustomButton(
          text: 'Accept',
          color: accent,
          height: resp.hp(5),
          width: resp.width,
          style: TextStyles.w600(16, Colors.white),
          onTap: () {
            if (reminder.description.isEmpty || reminder.title.isEmpty) {
              return;
            }
            onAcceptCallback(reminder);
          },
        ),
      ],
    );
  }
}
