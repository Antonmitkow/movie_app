import 'package:flutter/material.dart';
import 'package:test_app/custom_paint.dart';
import 'package:test_app/main_screen/main_screen.dart';
import 'package:test_app/movie_list/movie_detailed_widget.dart';
import 'package:test_app/theme/app_colors.dart';
import 'package:test_app/widgets/auth_widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The movie',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          appBarTheme:
              const AppBarTheme(backgroundColor: AppColors.mainDartBlue),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: AppColors.mainDartBlue,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey,
          )),
      // home: const AuthWidget(), q
      routes: {
        '/auth': (context) => const AuthWidget(),
        '/main_screen': (context) => const MainScreen(),
        '/custom_paint': (context) => const CustomPaintWidget(),
        '/main_screen/movie_detailed': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;
          if (arguments is int) {
            return MovieDetailedWidget(movieId: arguments);
          } else {
            return MovieDetailedWidget(movieId: 0);
          }
        },
      },
      initialRoute: '/auth',
      // onGenerateRoute: (RouteSettings settings) {
      //   return MaterialPageRoute<void>(builder: (context) {
      //     return const Scaffold(
      //         body: Center(child: Text('Произошла ошибка навигации')));
      //   });
      // },
    );
  }
}
