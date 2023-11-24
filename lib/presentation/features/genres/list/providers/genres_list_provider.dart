import 'package:flutter_guid/flutter_guid.dart';
import 'package:lyrics_library/presentation/providers/selectable_list_provider.dart';
import '/data/models/response_model.dart';
import '/presentation/features/genres/shared/models/genre_model.dart';
import '/presentation/providers/providers.dart';
import '/services/genres_service.dart';

class GenresListProvider extends FetchProvider<List<GenreModel>?> with SelectableListProvider<Guid>{
  final GenresService _genresService;

  GenresListProvider({
    required GenresService genresService
  }) : _genresService = genresService;

  
  GenreModel get getFirstGenreSelected => model!.firstWhere(
    (element) => element.id == selectedItems[0]
  );



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
  

  @override
  void openCloseSelectItem({Guid? id}) {
    super.openCloseSelectItem(
      id: id
    );
    notifyListeners();
  }

  @override
  void selectItem({required Guid id}) {
    super.selectItem(
      id: id
    );
    notifyListeners();
  }



  void deleteGenres(){
    model!.removeWhere((genre) => selectedItems.contains(genre.id));
    openCloseSelectItem();
    notifyListeners();
  }

  void editGenre(GenreModel genreModel){
    final index = model!.indexWhere((genre) => genre.id == genreModel.id);
    model![index] = genreModel;
    if(isSelectItemOpened){
      openCloseSelectItem();
    }
    notifyListeners();
  }

  

}