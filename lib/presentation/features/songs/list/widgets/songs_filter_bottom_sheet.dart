import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:injector/injector.dart';

import '/config/lang/generated/l10n.dart';
import '/data/models/response_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/presentation/presentation.dart';
import '/presentation/providers/fetch_provider.dart';
import '/presentation/widgets/buttons.dart';
import '/presentation/widgets/providers.dart';
import '/services/genres_service.dart';
import '/utils/constants/sizes.dart';

final selectGenresFiltersProvider = ChangeNotifierProvider.autoDispose<SelectGenresFiltersProvider>((ref) {
  return SelectGenresFiltersProvider( 
    genresService: Injector.appInstance.get()
  );
});

class SongsFilterBottomSheet extends ConsumerStatefulWidget {
  const SongsFilterBottomSheet({
    super.key,
    this.genreModel
  });

  final GenreModel? genreModel;

  @override
  ConsumerState<SongsFilterBottomSheet> createState() => _SongsFilterBottomSheetState();
}

class _SongsFilterBottomSheetState extends ConsumerState<SongsFilterBottomSheet> {

  @override
  void initState() {
    if(widget.genreModel != null){
      ref.read(selectGenresFiltersProvider).initializeValue(widget.genreModel!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final height = MediaQuery.sizeOf(context).height;
    final lang = Lang.of(context);
    final prov = ref.read(selectGenresFiltersProvider);
    final reactiveProv = ref.watch(selectGenresFiltersProvider);

    return Container(
      width: double.infinity,
      height: height,
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(Sizes.kBorderRadius),
            topRight: Radius.circular(Sizes.kBorderRadius)
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: kToolbarHeight,
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: Sizes.kPadding * 0.3,
                  ),
                  child: SizedBox(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 40,
                          width: 60,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5
                          ),
                          child: Text(
                            lang.songsFilterBotomShet_title,
                            style: theme.textTheme.titleSmall,
                          ),
                        ),
                        IconButton(
                          onPressed: ()=> Navigator.of(context).pop(),
                          icon:  Icon(
                            CupertinoIcons.xmark_circle_fill,
                            color: theme.colorScheme.onBackground,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: Sizes.kPadding,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 0.5,
                      color : theme.colorScheme.outline
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: Sizes.kPadding * 0.5,
                        horizontal : Sizes.kPadding
                      ),
                      child: Text(
                        lang.songsFilterBotomShet_byGenre,
                        style: theme.textTheme.titleSmall,
                      ),
                    ),
                    Container(
                      height: 0.5,
                      color : theme.colorScheme.outline
                    ),
                    const SizedBox(
                      height: Sizes.kPadding,
                    ),
                    FetchProviderBuilder(
                      provider: selectGenresFiltersProvider,
                      loaderWidget: const SizedBox(
                        height: 100,
                        child: LoadingWidget(),
                      ),
                      builder:(genres) {
                        return Column(
                          children: List.generate(
                            genres!.length, (index) {
                              final genre = genres[index];
                              return ListTile(
                                onTap: () {
                                  prov.selectGenre(genre.id);
                                  //widget.onGenreChanged(genre);
                                },
                                leading: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FadeInRight(
                                      duration: const Duration(milliseconds: 100),
                                      child: CupertinoCheckbox(
                                        checkColor: theme.colorScheme.onPrimary,
                                        activeColor: theme.colorScheme.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius)
                                        ),
                                        value: reactiveProv.isThisGenreSelected(genre.id),
                                        onChanged: (value){
                                          prov.selectGenre(genre.id);
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      width: Sizes.kPadding,
                                    ),
                                    FadeInRight(
                                      duration: const Duration(milliseconds: 100),
                                      child: GenreTileLeading(
                                        genreModel: genre,
                                      ),
                                    )
                                  ],
                                ),
                                title: FadeInRight(
                                  duration: const Duration(milliseconds: 100),
                                  child: Text(genre.name)
                                ),
                              );
                            }
                          )
                        );
                      }
                    ),
                    const SizedBox(
                      height: Sizes.kPadding,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: Sizes.kPadding
              ),
              child: BasicButton(
                onPressed: (){
                  GoRouter.of(context).pop(prov.selectedGenre);
                }, 
                text: lang.actions_apply
              ),
            ),
            const SizedBox(
              height: Sizes.kPadding * 1.5,
            ),
          ],
        ),
      ),
    );
  }
}


class SelectGenresFiltersProvider extends FetchProvider<List<GenreModel>?> {

  final GenresService _genresService;

  SelectGenresFiltersProvider({
    required GenresService genresService
  }) : _genresService = genresService;

  GenreModel? selectedGenre;

  bool get isOneGenreSelected => selectedGenre != null;


  @override
  Future<ResponseModel<List<GenreModel>?>> fetchMethod() {
    return _genresService.fetchGenres(
      query: ''
    );
  }

  void selectGenre(Guid genreId){
    if(genreId == selectedGenre?.id){
      selectedGenre = null;
    }else{
      selectedGenre = model!.firstWhere((genre) => genre.id == genreId);
    }
    notifyListeners();
  }

  void initializeValue(GenreModel genre){
    selectedGenre = genre;
  }

  bool isThisGenreSelected(Guid genreId){
    if(selectedGenre == null){
      return false;
    }
    return selectedGenre!.id == genreId;
  }

  
}