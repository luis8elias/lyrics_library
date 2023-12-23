import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_guid/flutter_guid.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injector/injector.dart';

import '/data/models/response_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/presentation/providers/providers.dart';
import '/presentation/widgets/loaders.dart';
import '/presentation/widgets/providers.dart';
import '/services/genres_service.dart';
import '/utils/constants/sizes.dart';

final selectGenresListProvider = ChangeNotifierProvider.autoDispose<_FetchGenresDialogProvider>((ref) {
  return _FetchGenresDialogProvider(
    genresService: Injector.appInstance.get(),
  );
});





class SelectGenreDialog extends StatefulWidget {
  const SelectGenreDialog({
    super.key, 
    required this.onGenreChanged,
    this.genreModel
  });

  final void Function(GenreModel genre) onGenreChanged;
  final GenreModel? genreModel;

  @override
  State<SelectGenreDialog> createState() => _SelectGenreDialogState();
}

class _SelectGenreDialogState extends State<SelectGenreDialog> {

  @override
  void initState() {
    genreModel = widget.genreModel;
    super.initState();
  }

  GenreModel? genreModel;

  Future<void> openDialog(BuildContext context, {
    GenreModel? initialValue
  }) async{

    final genre = await showDialog<GenreModel?>(
      context: context,
      builder: (BuildContext context) {
        return  _SelectGenreDialogUI(
          genreModel: initialValue,
          onGenreChanged : (genre) => widget.onGenreChanged(genre)
        );
      },
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
        onPressed: ()=> openDialog(context),
        child: const Text('Add Genre')
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
      onPressed: ()=> openDialog(context, initialValue: genreModel),
      child: Text(genreModel!.name)
    );
  }
}

class _SelectGenreDialogUI extends ConsumerStatefulWidget {
  const _SelectGenreDialogUI({
    this.genreModel,
    required this.onGenreChanged
  });

  final GenreModel? genreModel;
  final void Function(GenreModel genre) onGenreChanged;

  @override
  ConsumerState<_SelectGenreDialogUI> createState() => _SelectGenreDialogUIState();
}

class _SelectGenreDialogUIState extends ConsumerState<_SelectGenreDialogUI> {

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
    final prov = ref.read(selectGenresListProvider);
    final reactiveProv = ref.watch(selectGenresListProvider);

    return AlertDialog(
      elevation: 1.0,
      scrollable: true,
      contentPadding: EdgeInsets.zero,
      surfaceTintColor: theme.scaffoldBackgroundColor,
      backgroundColor: theme.scaffoldBackgroundColor,
      title: const Text('Add Genre'),
      content: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.5,
        child: FetchProviderBuilder(
          provider: selectGenresListProvider,
          loaderWidget: const LoadingScreen(),
          builder: (genres){
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: Sizes.kPadding,
                  ),
                  ...genres!.map((genre) {
                    return ListTile(
                      onTap: () {
                        prov.selectGenre(genre.id);
                        widget.onGenreChanged(genre);
                      },
                      leading: CupertinoCheckbox(
                        checkColor: theme.colorScheme.onPrimary,
                        activeColor: theme.colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Sizes.kRoundedBorderRadius)
                        ),
                        value: reactiveProv.isThisGenreSelected(genre.id), 
                        onChanged: (value){
                          prov.selectGenre(genre.id);
                          widget.onGenreChanged(genre);
                        },
                      ),
                      title: Text(
                        genre.name,
                        style: theme.textTheme.displaySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    );
                  },).toList(),
                ]
              ),
            );
          }
        )
      ),
      actions: <Widget>[
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: theme.colorScheme.outline
          ),
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: theme.textTheme.labelLarge,
          ),
          onPressed: (){
            final genre = reactiveProv.selectedGenre;
            if(genre != null){
              Navigator.pop(context,genre);
            }else{
              Navigator.pop(context,GenreModel.empty());
            }
          },
          child: const Text('Ok'),
        ),
      ],
    );
  }
  
  
}



class _FetchGenresDialogProvider extends FetchProvider<List<GenreModel>?> {

  final GenresService _genresService;

  _FetchGenresDialogProvider({
    required GenresService genresService
  }) : _genresService = genresService;


  GenreModel? selectedGenre;


  @override
  Future<ResponseModel<List<GenreModel>?>> fetchMethod() {
    return _genresService.fetchGenres();
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