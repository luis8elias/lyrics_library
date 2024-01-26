import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '/presentation/features/setlists/create/create_setlist_screen.dart';
import '/utils/constants/sizes.dart';


class CreateSetlistBtn extends StatelessWidget {
  const CreateSetlistBtn({super.key});

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    
    return InkWell(
      borderRadius: BorderRadius.circular(
        Sizes.kRoundedBorderRadius
      ),
      onTap: () => GoRouter.of(context).pushNamed(CreateSetlistScreen.routeName),
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius)
        ),
        child: Icon(
          CupertinoIcons.add,
          color: theme.colorScheme.onPrimary,
          size: 15,
        ),
      ),
    );
  }
}