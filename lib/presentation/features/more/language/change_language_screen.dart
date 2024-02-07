import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/app/providers/providers.dart';
import '/config/config.dart';
import '/config/lang/generated/l10n.dart';
import '/presentation/features/more/menu/menu_options_screen.dart';
import '/presentation/widgets/buttons.dart';
import '/utils/constants/sizes.dart';

class ChangeLanguageScreen extends ConsumerWidget {
  const ChangeLanguageScreen({super.key});

  static const String routePath = 'change-language';

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final lang = Lang.of(context);
    final theme = Theme.of(context);
    final appProv = ref.read(appProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          lang.changeLangScreen_title,
          style: theme.textTheme.titleSmall,
        ),
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackButtonWidget(
            onPressed: () {
              GoRouter.of(context).goNamed(
                MoreOptionsScreen.routeName
              );
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kPadding
        ),
        child: Center(
          child: LangListTiles(
            initialLocale: appProv.selectedLocale!,
          )
        ),
      ),
    );
  }
}




class LangListTiles extends ConsumerStatefulWidget {
  const LangListTiles({
    super.key,
    required this.initialLocale
  });

  final Locale initialLocale;

  @override
  ConsumerState<LangListTiles> createState() => _LangListTilesState();
}

class _LangListTilesState extends ConsumerState<LangListTiles> {

  late Locale selectedLocale;
  @override
  void initState() {
    selectedLocale = widget.initialLocale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final langProv = ref.read(appProvider);
    final lang = Lang.of(context);

    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(
          height: Sizes.kPadding * 1.5,
        ),
        Text(
          lang.changeLangScreen_subtitle,
          textAlign: TextAlign.center,
          style: theme.textTheme.displaySmall!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 15
          ),
        ),
        const SizedBox(
          height: Sizes.kPadding * 1.5,
        ),
        Material(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(Sizes.kBorderRadius),
            topRight: Radius.circular(Sizes.kBorderRadius),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
          ),
          color: theme.colorScheme.inverseSurface.withOpacity(0.6),
          child: RadioListTile<Locale>(
            title: const Text('Español'),
            subtitle: Text(lang.changeLangScreen_es),
            value: const Locale('es'),
            groupValue: selectedLocale,
            onChanged: (Locale? value) {
              setState(() {
                selectedLocale = value!;
              });
              langProv.changeLanguage(locale: const Locale('es'));
            },
            shape:  const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(Sizes.kBorderRadius),
                topRight: Radius.circular(Sizes.kBorderRadius),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0),
              ),
            ),
          ),
        ),
        Container(
          height: 0.5,
          color : theme.colorScheme.outline
        ),
        Material(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(0),
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(Sizes.kBorderRadius),
            bottomRight: Radius.circular(Sizes.kBorderRadius),
          ),
          color: theme.colorScheme.inverseSurface.withOpacity(0.6),
          child: RadioListTile<Locale>(
            title: const Text('English'),
            subtitle: Text(lang.changeLangScreen_en),
            value: const Locale('en'),
            groupValue: selectedLocale,
            onChanged: (Locale? value) {
              setState(() {
                selectedLocale = value!;
              });
              langProv.changeLanguage(locale: const Locale('en'));
            },
            shape:  const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(Sizes.kBorderRadius),
                bottomRight: Radius.circular(Sizes.kBorderRadius),
              ),
            ),
          ),
        ),
      ],
    );
  }
}