import 'package:flutter/material.dart';
import 'package:test_app/movie_list/movid_detailed_main_info_widget.dart';

class MovieDetailedWidget extends StatefulWidget {
  final movieId;
  const MovieDetailedWidget({Key? key, required this.movieId})
      : super(key: key);

  @override
  State<MovieDetailedWidget> createState() => _MovieDetailedWidgetState();
}

class _MovieDetailedWidgetState extends State<MovieDetailedWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The international'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          MovieDetailedMainInfoWidget(),
        ],
      ),
    );
  }
}
