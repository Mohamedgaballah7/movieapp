import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import '../../../../shared_preferences/shared_preferences.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/app_routes.dart';
import '../../../../utils/app_styles.dart';
import '../../../../widgets/custom_elevated_button.dart';
import 'cubit/profile_tab_view_model.dart';
import 'cubit/profile_tap_states.dart';
import 'history/history.dart';

class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  ProfileTabViewModel viewModel = ProfileTabViewModel();
  int historyCount = Hive
      .box('movies')
      .length;

  List<String> avatars = [
    AppAssets.avatar1Image,
    AppAssets.avatar2Image,
    AppAssets.avatar3Image,
    AppAssets.avatar4Image,
    AppAssets.avatar5Image,
    AppAssets.avatar6Image,
    AppAssets.avatar7Image,
    AppAssets.avatar8Image,
    AppAssets.avatar9Image,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewModel.getProfile();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<ProfileTabViewModel, ProfileTabStates>(
      bloc: viewModel,
      builder: (context, state) {
        if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(
                color: AppColors.yellowColor),);
        } else if (state is SuccessGetState) {
          return DefaultTabController(
            length: 2,
            child: Scaffold(
              body: Column(
                children: [
                  Container(
                    color: AppColors.greyDarkColor,
                    padding: EdgeInsets.symmetric(horizontal: width * 0.055),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: height * 0.055),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Image.asset(
                              avatars[state.avatarId!],
                              scale: 0.8,
                            ),
                            Column(
                              children: [
                                Text("0", style: AppStyles.bold36White),
                                SizedBox(height: height * 0.015),
                                Text(
                                    AppLocalizations.of(context)!.watch_list, style: AppStyles.bold20White),
                              ],
                            ),
                            Column(
                              children: [
                                Text("$historyCount",
                                    style: AppStyles.bold36White),
                                SizedBox(height: height * 0.015),
                                Text(AppLocalizations.of(context)!.history, style: AppStyles.bold20White),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        Text(
                          state.name!,
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleLarge,
                        ),
                        SizedBox(height: height * 0.02),
                        Row(
                          children: [
                            Expanded(
                              flex: 3,
                              child: CustomElevatedButton(
                                textStyle: AppStyles.regular20BlackR,
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.updateProfileRouteName,
                                  );
                                },
                                text: AppLocalizations.of(context)!.edit_profile,
                              ),
                            ),
                            SizedBox(width: width * 0.04),
                            Expanded(
                              flex: 2,
                              child: CustomElevatedButton(
                                hasIcon: true,
                                iconWidget: Icon(
                                  Icons.logout_outlined,
                                  color: AppColors.whiteColor,
                                  size: 25,
                                ),
                                backgroundColor: AppColors.redColor,
                                textStyle: AppStyles.regular20WhiteR,
                                onPressed: () {
                                  Navigator.pushNamedAndRemoveUntil(
                                    context,
                                    AppRoutes.loginRouteName,
                                        (route) => false,
                                  );
                                  SharedPreferencesAll.clearToken();
                                },
                                text: AppLocalizations.of(context)!.exit,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: height * 0.02),
                        TabBar(
                          enableFeedback: false,
                          indicatorWeight: 3,
                          indicatorSize: TabBarIndicatorSize.tab,
                          dividerColor: AppColors.transparentColor,
                          indicatorColor: AppColors.yellowColor,
                          labelColor: AppColors.yellowColor,
                          unselectedLabelColor: AppColors.whiteColor,
                          tabs: const [
                            Tab(icon: Icon(Icons.list, size: 40),
                                text: "Watch List"),
                            Tab(icon: Icon(Icons.folder, size: 40),
                                text: "History"),
                          ],
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: TabBarView(
                      children: [
                        // todo: Watch List Content
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(AppAssets.popcorn),
                              SizedBox(height: 10),
                              Text(
                                AppLocalizations.of(context)!.no_movies,
                                style: AppStyles.bold20WhiteR.copyWith(
                                  color: AppColors.yellowColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        //todo: History Content
                        History()
                      ],
                    ),
                  ),

                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}