import 'package:flutter/material.dart';

import '../widgets/custom_app_bar.dart';
import '../widgets/search_field_widget.dart';
import '../widgets/search_history_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: true,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(
          isFavoriteScreen: false,
          appBarTitle: 'Github repos list',
        ),
        body: Padding(
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
