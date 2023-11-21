import 'package:flutter_guid/flutter_guid.dart';
import '/data/models/response_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/presentation/providers/providers.dart';
import '/services/genres_service.dart';

class GenresListProvider extends FetchProvider<List<GenreModel>?>{
  final GenresService _genresService;

  GenresListProvider({
    required GenresService genresService
  }) : _genresService = genresService;

  bool isSelectGenreOpened = false;

  final List<Guid> selectedGenres = [];
  bool get isOneGenreSelected => selectedGenres.length == 1;
  GenreModel get getFirstGenreSelected => model!.firstWhere((element) => element.id == selectedGenres[0]);



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
    model!.add(genreModel);
    notifyListeners();
  }

  void openCloseSelectGenre({
    Guid? genreId
  }) {
    isSelectGenreOpened = !isSelectGenreOpened;
    if(!isSelectGenreOpened){
      selectedGenres.clear();
    }
    if(genreId != null){
      selectedGenres.add(genreId);
    }
    notifyListeners();
  }


  void selectGenre(Guid genreId){
    if(selectedGenres.contains(genreId)){
      selectedGenres.removeWhere((element) => element == genreId);
    }else{
      selectedGenres.add(genreId);
    }
    notifyListeners();
  }

  void deleteGenres(){
    model!.removeWhere((genre) => selectedGenres.contains(genre.id));
    openCloseSelectGenre();
    notifyListeners();
  }

  void editGenre(GenreModel genreModel){
    final index = model!.indexWhere((genre) => genre.id == genreModel.id);
    model![index] = genreModel;
    openCloseSelectGenre();
    notifyListeners();
  }

  

}