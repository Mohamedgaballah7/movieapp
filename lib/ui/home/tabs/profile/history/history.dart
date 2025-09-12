import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/ui/home/tabs/home/custom_movie_card.dart';

import '../../../../../model/api_responses/movie_response.dart';
import '../../../../../utils/app_colors.dart';
import '../../../../../utils/app_routes.dart';
import '../../../../../utils/app_styles.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  static List<Movies> allMovies = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHistoryList();
  }

  void getHistoryList() async {
    var box = await Hive.openBox('movies');
    if (box.isEmpty) {
      allMovies = [];
    } else {
      allMovies = box.values
          .map((e) => Movies.fromJson(Map<String, dynamic>.from(e)))
          .toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    if (allMovies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.history, size: 80, color: AppColors.yellowColor),
            SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.no_movies,
              style: AppStyles.bold20WhiteR.copyWith(
                color: AppColors.yellowColor,
              ),
            ),
          ],
        ),
      );
    }
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.02,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.movieDetailsRouteName,
              arguments: allMovies[index].id,
            );
          },
          child: CustomMovieCard(movie: allMovies[index]),
        );
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: width * 0.03,
        childAspectRatio: 3 / 5,
      ),
      itemCount: allMovies.length,
    );
  }
}
