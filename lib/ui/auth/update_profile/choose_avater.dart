import 'package:flutter/material.dart';
import 'package:movieapproute/utils/app_colors.dart';

import '../../../utils/app_assets.dart';

class ChooseAvater extends StatefulWidget {
  int selectedAvatar;

  ChooseAvater({super.key, required this.selectedAvatar});

  @override
  State<ChooseAvater> createState() => _ChooseAvaterState();
}

class _ChooseAvaterState extends State<ChooseAvater> {
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
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: width * 0.02,
        vertical: height * 0.01,
      ),
      height: height * 0.46,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              widget.selectedAvatar = index;
              Navigator.pop(context, widget.selectedAvatar);
              setState(() {});
            },
            child: Container(
              decoration: BoxDecoration(
                color: widget.selectedAvatar == index
                    ? AppColors.yellowColor.withOpacity(0.3)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: AppColors.yellowColor, width: 1.5),
              ),
              child: Image.asset(avatars[index], scale: 0.9),
            ),
          );
        },
        itemCount: avatars.length,
      ),
    );
  }
}
