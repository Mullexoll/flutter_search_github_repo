import 'package:flutter/material.dart';
import 'package:search_github_repo_flutter/presentation/helpers/widget_helper.dart';
import 'package:search_github_repo_flutter/presentation/ui/screens/favorite_screen.dart';

import '../widgets/favorite_icon_widget.dart';
import '../widgets/search_field_widget.dart';
import '../widgets/search_history_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(76),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 44,
                    ),
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Github repos list',
                          textAlign: TextAlign.center,
                          style: WidgetHelper().getTextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0, bottom: 5),
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
                    ),
                  ],
                ),
                Container(
                  height: 2,
                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color:
                            Color.fromRGBO(0, 0, 0, 0.03), // Box shadow color
                        offset: Offset(0, 3), // Offset (X, Y)
                        blurRadius: 1.0, // Blur radius
                        spreadRadius: 0.0, // Spread radius
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(),
              SizedBox(
                height: 16,
              ),
              SearchHistoryWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
