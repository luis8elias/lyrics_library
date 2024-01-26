import 'package:flutter/material.dart';

import '/config/lang/generated/l10n.dart';
import '/presentation/features/setlists/shared/models/setlist_model.dart';
import '/presentation/widgets/inputs.dart';
import '/utils/utils.dart';

class SetlistForm extends StatelessWidget {
  const SetlistForm({
    super.key,
    required this.onNameChanged,
    required this.actionButton,
    this.setlistModel,
  });

  final SetlistModel? setlistModel;
  final void Function(String name) onNameChanged;
  final Widget actionButton;
  
  @override
  Widget build(BuildContext context) {

    final lang = Lang.of(context);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kPadding
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: Sizes.kPadding * 2,
            ),
            BasicInput(
              initalValue: setlistModel?.name,
              label: lang.setlistsEditScreen_nameInput,
              validator: (value) => Validator.validateRequired(value!.trim()),
              onChanged: (value) => onNameChanged(value),
            ),
            const SizedBox(
              height: Sizes.kPadding * 2,
            ),
            actionButton
          ],
        ),
      ),
    );
  }
}