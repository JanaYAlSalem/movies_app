import 'package:movies_app/models/MovieModel.dart';
import 'package:http/http.dart' as http ;

class MoviesApiService {

  Future<Welcome?> getMovies() async {
    var client = http.Client();
    var uri = Uri.parse("https://api.themoviedb.org/3/movie/popular?api_key=91e0a4801858875d926759b32da2ac56");
    var response = await client.get(uri);

    if (response.statusCode == 200){
      var json = response.body;
      return welcomeFromJson(json);

    }
  }
}