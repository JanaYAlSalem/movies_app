import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_app/ui/screens/HomeScreen.dart';

// package
import '../../models/MovieModel.dart';


class DetailsScreen extends StatelessWidget {

  const DetailsScreen({required this.movieItem,});

  final Result movieItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(movieItem.title!),
        backgroundColor: Colors.red[700],
        elevation: 50.0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          tooltip: 'Back',
          onPressed: () {
            Navigator.pop(context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen()),);
          },
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      // Wrap with widget [SafeArea] because save the space bar
      body: SafeArea(
        // Padding space start Column
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // to start text from left
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
            Container(
            height: 450,
            width: 500,
            alignment: Alignment.center,
            child:
            Image(
              alignment: Alignment.center,
              image: NetworkImage("https://image.tmdb.org/t/p/original/${movieItem.posterPath}"),
              fit: BoxFit.contain,
            ),
          ),
              SizedBox(height: 32,),
              Text(movieItem.title!, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500,color: Colors.grey[700]),),
              //SizedBox: to space between texts
              SizedBox(height: 8,),
              Container(
                width: 400,
                child : Text(movieItem.overview!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300, color: Colors.grey[700])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}