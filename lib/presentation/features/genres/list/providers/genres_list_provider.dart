import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/data/models/response_model.dart';
import 'package:lyrics_library/presentation/features/genres/shared/models/genre_model.dart';
import 'package:lyrics_library/presentation/providers/providers.dart';
import 'package:lyrics_library/services/genres_service.dart';

class GenresListProvider extends FetchProvider<List<GenreModel>?>{
  final GenresService _genresService;

  GenresListProvider({
    required GenresService genresService
  }) : _genresService = genresService;

  bool isSelectGenreOpened = false;

  final List<Guid> selectedGenres = [];



  @override
  Future<ResponseModel<List<GenreModel>?>> fetchMethod() {
    return _genresService.fetchGenres();
  }

  Future<void> refreshGenres() async{
    loadData();
  }

  Future<void> addGenre({required 
    GenreModel genreModel
  }) async{
    final currentGenres = model;
    currentGenres?.add(genreModel);
    model = currentGenres;
    notifyListeners();
  }

  void openCloseSelectGenre() {
    isSelectGenreOpened = !isSelectGenreOpened;
    if(!isSelectGenreOpened){
      _clearSelectedGenres();
    }
    notifyListeners();
  }

  void _clearSelectedGenres(){
    selectedGenres.clear();
  }

  void selectGenre(Guid genreId){
    if(selectedGenres.contains(genreId)){
      selectedGenres.removeWhere((element) => element == genreId);
    }else{
      selectedGenres.add(genreId);
    }
    notifyListeners();
  }

  

}