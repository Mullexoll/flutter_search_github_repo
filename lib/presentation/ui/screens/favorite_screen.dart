import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_github_repo_flutter/presentation/ui/widgets/custom_app_bar.dart';

import '../../../bloc/repository_bloc.dart';
import '../widgets/repository_item_widget.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepositoryBloc, RepositoryState>(
      builder: (context, state) {
        return SafeArea(
          top: true,
          child: Scaffold(
            appBar: const CustomAppBar(
              isFavoriteScreen: true,
              appBarTitle: 'Favorite repos list',
            ),
            body: (state as RepositoryLoaded).favoriteRepositories.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView.builder(
                      itemCount: (state).favoriteRepositories.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, idx) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: RepositoryItem(
                            repositoryItem: state.favoriteRepositories[idx],
                            isFavoriteScreen: true,
                          ),
                        );
                      },
                    ),
                  )
                : const Center(
                    child: Center(
                      child: Text(
                        '''You have no favorites. 
  Click on the star while searching to add the first favorite''',
                        style: TextStyle(
                          color: Color(
                              0xFFBFBFBF), // Replace with your desired color
                          fontFamily: "Raleway",
                          fontSize: 14,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w400,
                          height: 1.4, // 140%
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
