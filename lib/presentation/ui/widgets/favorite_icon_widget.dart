import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_github_repo_flutter/constants/application_constants.dart';

class FavoriteIconWidget extends StatelessWidget {
  final Function onFavoriteIconTap;

  const FavoriteIconWidget({
    super.key,
    required this.onFavoriteIconTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onFavoriteIconTap(),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: SearchAppConstants.primaryColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: SvgPicture.asset(
          'assets/icons/favorite_star_icon.svg',
          width: 20,
          height: 19.84,
          fit: BoxFit.none,
          // colorFilter: ColorFilter.mode(
          //   iconsColor,
          //   BlendMode.srcIn,
          // ),
        ),
      ),
    );
  }
}
