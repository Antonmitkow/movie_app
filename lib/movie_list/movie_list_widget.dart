import 'package:flutter/material.dart';

class Movies {
  final int id;
  final String title;
  final String time;
  final String description;
  Movies({
    required this.id,
    required this.title,
    required this.time,
    required this.description,
  });
}

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  final _movies = [
    Movies(
        id: 1,
        title: 'Смертельная битва',
        time: '1 декабря 2021',
        description:
            'это американская серия боевиков о боевых искусствах, основанная на одноименной серии видеоигр о файтингах от Midway Games. Первый фильм был произведен компанией Threshold Entertainment Лоуренса Касаноффа.'),
    Movies(
        id: 2,
        title: 'Трансформеры',
        time: '1 декабря 2021',
        description:
            'это американская серия боевиков о боевых искусствах, основанная на одноименной серии видеоигр о файтингах от Midway Games. Первый фильм был произведен компанией Threshold Entertainment Лоуренса Касаноффа.'),
    Movies(
        id: 3,
        title: 'Аватар',
        time: '1 декабря 2021',
        description:
            'это американская серия боевиков о боевых искусствах, основанная на одноименной серии видеоигр о файтингах от Midway Games. Первый фильм был произведен компанией Threshold Entertainment Лоуренса Касаноффа.'),
    Movies(
        id: 4,
        title: 'True sight',
        time: '1 декабря 2021',
        description:
            'это американская серия боевиков о боевых искусствах, основанная на одноименной серии видеоигр о файтингах от Midway Games. Первый фильм был произведен компанией Threshold Entertainment Лоуренса Касаноффа.'),
    Movies(
        id: 5,
        title: 'The international',
        time: '1 декабря 2021',
        description:
            'это американская серия боевиков о боевых искусствах, основанная на одноименной серии видеоигр о файтингах от Midway Games. Первый фильм был произведен компанией Threshold Entertainment Лоуренса Касаноффа.')
  ];

  final _searchController = TextEditingController();

  var _filterMovies = <Movies>[];

  void _searchMovies() {
    final query = _searchController.text;

    setState(() {
      if (query.isNotEmpty) {
        _filterMovies = _movies.where((Movies movie) {
          return movie.title.toLowerCase().contains(query.toLowerCase());
        }).toList();
      } else {
        _filterMovies = _movies;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _filterMovies = _movies;
    _searchController.addListener(_searchMovies);
  }

  void _onMovieTap(int index) {
    final id = _movies[index].id;
    Navigator.of(context)
        .pushNamed('/main_screen/movie_detailed', arguments: id);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(top: 70),
            keyboardDismissBehavior:
                ScrollViewKeyboardDismissBehavior.onDrag, // скрол при поиске
            itemCount: _filterMovies.length,
            itemExtent: 163,
            itemBuilder: (BuildContext context, int index) {
              final movie = _filterMovies[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border:
                              Border.all(color: Colors.black.withOpacity(0.2)),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            )
                          ]),
                      clipBehavior: Clip.hardEdge,
                      child: Row(
                        children: [
                          Image.asset('images/kino.png'),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  movie.title,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  movie.time,
                                  style: const TextStyle(color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  movie.description,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => _onMovieTap(index),
                      ),
                    )
                  ],
                ),
              );
            }),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
                label: const Text('Поиск'),
                filled: true,
                fillColor: Colors.white.withAlpha(235),
                border: const OutlineInputBorder()),
          ),
        ),
      ],
    );
  }
}
