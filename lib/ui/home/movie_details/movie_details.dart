import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/ui/home/movie_details/cubit/movie_details_states.dart';
import 'package:movieapproute/ui/home/movie_details/cubit/movie_details_view_model.dart';
import 'package:movieapproute/ui/home/movie_details/widgets/custom_cast_container.dart';
import 'package:movieapproute/ui/home/movie_details/widgets/custom_genres_container.dart';
import 'package:movieapproute/ui/home/movie_details/widgets/custom_movie_suggestion_card.dart';
import 'package:movieapproute/ui/home/movie_details/widgets/custom_react_time_like_container.dart';
import 'package:movieapproute/ui/home/movie_details/widgets/custom_screen_shots_images.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_styles.dart';
import 'package:movieapproute/widgets/custom_elevated_button.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatefulWidget {
  const MovieDetails({super.key});

  @override
  State<MovieDetails> createState() => _MovieDetailsState();
}


class _MovieDetailsState extends State<MovieDetails> {
  late int movieId;
  MovieDetailsViewModel viewModel = MovieDetailsViewModel();

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.getMovieDetails(movieId);
    },);
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    movieId = ModalRoute
        .of(context)!
        .settings
        .arguments as int;

    return BlocBuilder<MovieDetailsViewModel, MovieDetailsStates>
      (bloc: viewModel,
      builder: (context, state) {
        if (state is LoadingState) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.yellowColor,
            ),
          );
        }
        else if (state is ErrorState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(state.message, style: AppStyles.semiBold20Yellow,),
              ElevatedButton(
                  onPressed: () {
                    //todo: try again
                  },
                  child: Text('Try Again',
                    style: AppStyles.medium16yellow,))
            ],
          );
        }
        else if (state is SuccessState) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [

                  Container(
                    decoration: BoxDecoration(

                      image: DecorationImage(
                        image: NetworkImage(state.backGroundImage!,),
                        fit: BoxFit.fill,
                      ),
                    ),
                    child: SafeArea(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                        child: Column(
                          spacing: height * 0.1,

                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_new,
                                    color: AppColors.whiteColor,
                                  ),
                                ),

                                IconButton(onPressed: () {
                                  state.isFavourite! ?
                                  viewModel.removeMovie(movieId) :
                                  viewModel.addMovieToFavorite(
                                      movieId, state.movieName!, state.rate!,
                                      state.backGroundImage!, state.year!);
                                  //Navigator.pop(context);
                                },
                                    icon: state.isFavourite!
                                        ? Icon(Icons.favorite,
                                      color: AppColors.yellowColor, size: 30,)
                                        : Icon(Icons.favorite,
                                        color: AppColors.whiteColor, size: 30)
                                )
                              ],
                            ),
                            Image.asset(AppAssets.videoPlayIcon),
                            //todo: Movie name
                            Text(
                              state.movieName!,
                              style: AppStyles.bold16White,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: width * 0.03),
                    child: Column(
                      spacing: height * 0.02,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //todo: year of the movie
                        Center(child: Text(
                            '${state.year}', style: AppStyles.medium12Gray)),
                        SizedBox(
                          width: double.infinity,
                          child: CustomElevatedButton(
                            backgroundColor: AppColors.redColor,
                            //todo:open movie url
                            onPressed: () async {
                              launch(state.movieUrl!);
                              var box = Hive.box("movies");
                              await box.put(
                                  state.movie!.id, state.movie!.toJson());
                            },
                            text: AppLocalizations.of(context)!.watch,
                            textStyle: AppStyles.medium20White,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomReactTimeLikeContainer(
                              width: width,
                              //todo: likes number
                              text: '${state.likes}',
                              icon: CupertinoIcons.heart_solid,
                            ),
                            CustomReactTimeLikeContainer(
                              width: width,
                              //todo: movie duration
                              text: '${state.time}',
                              icon: CupertinoIcons.clock_fill,
                            ),
                            CustomReactTimeLikeContainer(
                              width: width,
                              //todo: rating of the movie
                              text: '${state.rate}',
                              icon: CupertinoIcons.star_fill,
                            ),
                          ],
                        ),
                        Text(AppLocalizations.of(context)!.screen_shot,
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleLarge),
                        CustomScreenShotsImages(imagePath: state.screenShot1!),
                        CustomScreenShotsImages(imagePath: state.screenShot2!),
                        CustomScreenShotsImages(imagePath: state.screenShot3!),
                        Text(AppLocalizations.of(context)!.similar, style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge),
                        //todo:suggestion movies
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: width * 0.02),
                          child: SizedBox(
                            height: height * 0.2,
                            child:
                            ListView.separated(
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return CustomMovieSuggestionCard(
                                      movie: state.similarMovie![index]);
                                },
                                separatorBuilder: (context, index) {
                                  return SizedBox(width: width * 0.02,);
                                },
                                itemCount: state.similarMovie!.length
                            ),
                          ),
                        ),
                        Text(AppLocalizations.of(context)!.summary, style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge),
                        //todo:summary of tha movie
                        Text(
                          state.summary!,
                          //'Following the events of Spider-Man No Way Home, Doctor Strange unwittingly casts a forbidden spell that accidentally opens up the multiverse. With help from Wong and Scarlet Witch, Strange confronts various versions of himself as well as teaming up with the young America Chavez while traveling through various realities and working to restore reality as he knows it. Along the way, Strange and his allies realize they must take on a powerful new adversary who seeks to take over the multiverse.—Blazer346',
                          style: AppStyles.medium14White,
                        ),
                        Text(AppLocalizations.of(context)!.cast, style: Theme
                            .of(context)
                            .textTheme
                            .titleLarge),
                        SizedBox(
                          height: height * 0.45,
                          child: ListView.separated(
                              padding: EdgeInsets.zero,
                              itemBuilder: (context, index) {
                                return CustomCastContainer(
                                    imagePath: state.cast![index]
                                        .urlSmallImage ?? '',
                                    //todo: name of the actor
                                    name: '${state.cast![index].name}',
                                    character: '${state.cast![index]
                                        .characterName}');
                              },
                              separatorBuilder: (context, index) {
                                return SizedBox(height: height * 0.02,);
                              },
                              itemCount: state.cast!.length
                          ),
                        ),
                        SizedBox(
                          height: height * 0.15,
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: state.genres!.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 3.447368421,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10
                            ),
                            itemBuilder: (context, index) {
                              return CustomGenresContainer(
                                  type: state.genres![index]);
                            },),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },);
  }
}