import 'package:flutter/material.dart';
import 'package:movieapproute/l10n/app_localizations.dart';
import 'package:movieapproute/utils/app_assets.dart';
import 'package:movieapproute/utils/app_colors.dart';
import 'package:movieapproute/utils/app_styles.dart';

class WatchList extends StatefulWidget {
  WatchList({super.key});

  @override
  State<WatchList> createState() => _WatchListState();
}

class _WatchListState extends State<WatchList> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
    );
  }
}
