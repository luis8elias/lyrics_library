import 'package:lyrics_library/data/models/response_model.dart';

abstract class GenresDataSource{

  Future<ResponseModel<List<String>?>> fetchSongs();

}