import 'package:flutter/material.dart';
// systemOverlayStyle need
import 'package:flutter/services.dart';

import 'package:movies_app/ui/screens/DetailsScreen.dart';
import '../../models/MovieModel.dart';
import '../../network/MoviesApiService.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  MovieModel? movie;
  var isLoaded = false;

  @override
  void initState() {
    super.initState();
    // fetch data
    getData();
  }

  getData() async {
    movie = await MoviesApiService().getMovies();
    if (movie != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Movies"),
          backgroundColor: Colors.red[700],
          elevation: 50.0,
          leading: IconButton(
            icon: const Icon(Icons.menu),
            tooltip: 'Menu',
            onPressed: () {},
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: Visibility(
          visible: isLoaded,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: ListView.builder(
              itemCount: movie?.results?.length,
              itemBuilder: (context, index) {
                return Container(
                    child: CustomItem(
                  movieItem: movie!.results![index],
                )
                    // Text(movie!.results![index].overview!),
                    );
              }),
        )
    );
  }
}

class CustomItem extends StatelessWidget {
  const CustomItem({
    required this.movieItem,
  });

  final Result movieItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      // to start text from left
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              height: 178,
              width: 128,
              child: Image(
                image: NetworkImage(
                    "https://image.tmdb.org/t/p/original/${movieItem.posterPath}"),
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(
              width: 34,
            ),
            Column(
              // to start text from left
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 400,
                  child: Text(
                    movieItem.title!,
                    style: TextStyle(fontSize: 34),
                  ),
                ),
                Container(
                  width: 400,
                  child: Text(
                    movieItem.overview!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.red[700],
                    onPrimary: Colors.white,),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DetailsScreen(movieItem: movieItem,)),);
                  },
                  child: Text("More Details", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
