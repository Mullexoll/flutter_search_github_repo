import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants/application_constants.dart';
import '../../helpers/widget_helper.dart';
import '../screens/favorite_screen.dart';
import 'favorite_icon_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  final bool isFavoriteScreen;
  final String appBarTitle;

  const CustomAppBar({
    super.key,
    required this.isFavoriteScreen,
    required this.appBarTitle,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: 76, // Set the preferredSize
      elevation: 0,
      automaticallyImplyLeading: false, // Remove the shadow
      backgroundColor: Colors.transparent, // Make the background transparent
      actions: [
        if (!isFavoriteScreen)
          Padding(
            padding: const EdgeInsets.only(right: 16.0, bottom: 5),
            child: Align(
              alignment: Alignment.centerRight,
              child: FavoriteIconWidget(
                onFavoriteIconTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => const FavoriteScreen()),
                  ),
                ),
              ),
            ),
          )
      ],
      title: Row(
        mainAxisAlignment: isFavoriteScreen
            ? MainAxisAlignment.spaceBetween
            : MainAxisAlignment.center,
        children: [
          if (isFavoriteScreen)
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 5),
              child: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: SearchAppConstants.primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: SvgPicture.asset(
                    'assets/icons/back_icon.svg',
                    width: 20,
                    height: 19.84,
                    fit: BoxFit.none,
                  ),
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(left: isFavoriteScreen ? 0 : 32.0),
            child: Text(
              appBarTitle,
              style: WidgetHelper().getTextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (isFavoriteScreen)
            const SizedBox(
              width: 64,
              height: 72,
            ), // Add some space on the right
        ],
      ),
      // Divider below the AppBar
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(
          height: 2,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.03),
                offset: Offset(0, 3),
                blurRadius: 1.0,
                spreadRadius: 0.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => const Size.fromHeight(76);
}
