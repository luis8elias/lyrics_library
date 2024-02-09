import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '/config/config.dart';
import '/presentation/features/more/font_size/providers/providers.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/utils/utils.dart';

class ChangeFontSizeScreen extends ConsumerWidget {
  const ChangeFontSizeScreen({super.key});

  static const String routePath = 'change-font-size';

  
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final lang = Lang.of(context);
    final theme = Theme.of(context);
    final prov = ref.read(changeFontSizeProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          lang.changefontSizeScreen_title,
          style: theme.textTheme.titleSmall,
        ),
        leading:Padding(
          padding: const EdgeInsets.all(8.0),
          child: BackButtonWidget(
            onPressed: () {
              GoRouter.of(context).pop();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: Sizes.kPadding
        ),
        child: Center(
          child: FetchProviderBuilder(
            provider: changeFontSizeProvider,
            builder:( newFontSize ) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150,
                    child: Text(
                      lang.changefontSizeScreen_subtitle,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: newFontSize
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.kPadding * 2,
                  ),
                  Text(
                    '${lang.changefontSizeScreen_currentValue}: $newFontSize',
                    style: theme.textTheme.bodySmall!.copyWith(
                      fontSize: 15
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.kPadding * 2,
                  ),
                  Slider(
                    min: 15,
                    max: 30,
                    divisions: 15,
                    value: newFontSize,
                    inactiveColor: theme.colorScheme.inverseSurface,
                    onChanged: (newFontSize){
                      prov.changeFontSize(newFontSize);
                    }
                  ),
                  const SizedBox(
                    height: Sizes.kPadding * 2,
                  ),
                  const _SaveFontSizeBtn(),
                  const SizedBox(
                    height: Sizes.kPadding * 6,
                  ),
                ],
              );
            },
          )
        ),
      ),
    );
  }
}

class _SaveFontSizeBtn extends ConsumerStatefulWidget {
  const _SaveFontSizeBtn();

  @override
  ConsumerState<_SaveFontSizeBtn> createState() => __SaveFontSizeBtnState();
}

class __SaveFontSizeBtnState extends ConsumerState<_SaveFontSizeBtn> {
  @override
  Widget build(BuildContext context) {

  
    final lang = Lang.of(context);

    ref.listen(changeFontSizeProvider, (previous, next) {     
      if (next.responseModel != null 
        && next.responseModel!.isFailed 
        && !next.isSaveLoading
        && next.showSnackbar
      ) {
        SnackbarHelper.show(context: context, message: next.responseModel!.message!);
        next.resetShowSanckbar();
      }
      if (next.responseModel != null 
        && next.responseModel!.success 
        && !next.isSaveLoading
        && next.showSnackbar
      ) {
        SnackbarHelper.show(context: context, message: next.responseModel!.message!);
        next.resetShowSanckbar();
      }
    });

    final reactiveProv = ref.watch(changeFontSizeProvider);
    final prov = ref.read(changeFontSizeProvider);

    if(reactiveProv.isSaveLoading){
      return BasicButton(
        onPressed: null,
        buildChild: (loadingChild) => loadingChild,
        text: lang.loginScreen_buttonText
      );
    }


    return BasicButton(
    
      onPressed: () => {
        prov.saveFontSize()
      },
      text: lang.actions_save
    );
  }
}

