import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';
import 'package:lyrics_library/data/models/response_model.dart';
import 'package:lyrics_library/presentation/features/genres/list/genres_list_screen.dart';
import 'package:lyrics_library/presentation/providers/fetch_provider.dart';
import 'package:lyrics_library/presentation/widgets/buttons.dart';
import 'package:lyrics_library/presentation/widgets/providers.dart';
import 'package:lyrics_library/presentation/widgets/search_input.dart';
import 'package:lyrics_library/services/genres_service.dart';
import 'package:lyrics_library/utils/constants/sizes.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';

final selectGenresListProvider = ChangeNotifierProvider.autoDispose<_FetchGenresDialogProvider>((ref) {
  return _FetchGenresDialogProvider(
    genresService: Injector.appInstance.get(),
  );
});

class SelectGenreBottomSheet extends StatefulWidget {
  const SelectGenreBottomSheet({
    super.key,
    this.genreModel,
    required this.onGenreChanged
  });

  final void Function(GenreModel genre) onGenreChanged;
  final GenreModel? genreModel;

  @override
  State<SelectGenreBottomSheet> createState() => _SelectGenreBottomSheetState();
}

class _SelectGenreBottomSheetState extends State<SelectGenreBottomSheet> {

  @override
  void initState() {
    genreModel = widget.genreModel;
    super.initState();
  }

  GenreModel? genreModel;


   Future<void> openBottomSheet(BuildContext context, {
    GenreModel? initialValue
  }) async{

    final genre = await showModalBottomSheet(
      enableDrag: false,
      context: context, 
      isScrollControlled: true,
      builder: (context) => _SelectGenreBottomSheetUI(
        genreModel: initialValue,
        onGenreChanged : (genre) {
          widget.onGenreChanged(genre);
        }
      )
    );

    if(genre == null){
      return;
    }

    if(genre.isEmpty){

      setState(() {
        genreModel = null;
      });
      return;

    }
    
    setState(() {
      genreModel = genre;
    });
    
  }

  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);

    if(genreModel == null){
      return TextButton(
        onPressed: ()=> openBottomSheet(context),
        child: const Text('Select Genre')
      );
    }

    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: theme.colorScheme.primary.withOpacity(0.3),
        foregroundColor: theme.colorScheme.onBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
          side: BorderSide(
            color: theme.colorScheme.primary
          )
        )
      ),
      onPressed: ()=> openBottomSheet(context, initialValue: genreModel),
      child: Text(genreModel!.name)
    );
  }
}

class _SelectGenreBottomSheetUI extends ConsumerStatefulWidget {
  const _SelectGenreBottomSheetUI({
    this.genreModel,
    required this.onGenreChanged
  });

  final GenreModel? genreModel;
  final void Function(GenreModel genre) onGenreChanged;

  @override
  ConsumerState<_SelectGenreBottomSheetUI> createState() => __SelectGenreBottomSheetUIState();
}

class __SelectGenreBottomSheetUIState extends ConsumerState<_SelectGenreBottomSheetUI> {

  @override
  void initState() {
    if(widget.genreModel != null){
      ref.read(selectGenresListProvider).initializeValue(widget.genreModel!);
    }
    
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    final theme = Theme.of(context);
    final height = MediaQuery.sizeOf(context).height;
    final prov = ref.read(selectGenresListProvider);
    final reactiveProv = ref.watch(selectGenresListProvider);

    return  GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
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
                              'Select genre',
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
                      )
                    ),
                  ),
                  const SizedBox(
                    height: Sizes.kPadding,
                  ),
                ],
              ),
              Expanded(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: Sizes.kPadding
                      ),
                      child: SearchInput(
                        onChangeSearch: (query) => {
                          prov.updateQuery(query)
                        },
                        autoFocus: false,
                      ),
                    ),
                    const SizedBox(
                      height: Sizes.kPadding,
                    ),
                    Expanded(
                      child: FetchProviderBuilder(
                        provider: selectGenresListProvider,
                        builder:(genres) {
                          
                          return ListView.builder(
                          itemCount: genres!.length,
                          itemBuilder: (context, index) {
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
                                        //widget.onGenreChanged(genre);
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: Sizes.kPadding,
                                  ),
                                  FadeInRight(
                                    duration: const Duration(milliseconds: 100),
                                    child: GenreTileLeading(
                                      genreModel: genres[index],
                                    ),
                                  )
                                ],
                              ),
                              title: FadeInRight(
                                duration: const Duration(milliseconds: 100),
                                child: Text(genres[index].name)
                              ),
                            );
                          },
                        );
                        }
                      ),
                    ),
                    const SizedBox(
                      height: Sizes.kPadding,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: Sizes.kPadding
                ),
                child: BasicButton(
                  onPressed: (){
                    final genre = reactiveProv.selectedGenre ?? GenreModel.empty();
                    widget.onGenreChanged(genre);
                    Navigator.pop(context,genre);
                  }, 
                  text: 'OK'
                ),
              ),
              const SizedBox(
                height: Sizes.kPadding * 1.5,
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class _FetchGenresDialogProvider extends FetchProvider<List<GenreModel>?> {

  final GenresService _genresService;

  _FetchGenresDialogProvider({
    required GenresService genresService
  }) : _genresService = genresService;


  GenreModel? selectedGenre;
  String _query = '';


  bool get isOneGenreSelected => selectedGenre != null;

  @override
  Future<ResponseModel<List<GenreModel>?>> fetchMethod() {
    return _genresService.fetchGenres(
      query: _query
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

  void updateQuery(String newQuery){
    if(newQuery.isEmpty && _query.isEmpty){
      return;
    }
    _query = newQuery;
    loadData();
    log('[ GenresListProvider ] Query 👉🏼 $_query');
  }

}