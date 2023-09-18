import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_github_repo_flutter/presentation/helpers/widget_helper.dart';

import '../../../bloc/repository_bloc.dart';
import '../../../constants/application_constants.dart';
import 'repository_item_widget.dart';

class SearchHistoryWidget extends StatelessWidget {
  const SearchHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RepositoryBloc, RepositoryState>(
      builder: (context, state) {
        if (state is RepositoryLoaded && state.isSearchStarted) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Search History',
                  style: TextStyle(
                    color: SearchAppConstants.primaryColor,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    height: 16 / 18.78,
                  ),
                ),
                if (state is RepositoryLoaded &&
                    state.fetchedRepositories.isNotEmpty)
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount: state.fetchedRepositories.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, idx) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: RepositoryItem(
                            repositoryItem: state.fetchedRepositories[idx],
                            isFavoriteScreen: false,
                          ),
                        );
                      },
                    ),
                  )
                else
                  Container(
                    padding: const EdgeInsets.only(top: 16),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.75,
                    child: ListView.builder(
                      keyboardDismissBehavior:
                          ScrollViewKeyboardDismissBehavior.onDrag,
                      itemCount:
                          (state as RepositoryLoaded).repositoryHistory.length,
                      shrinkWrap: true,
                      itemBuilder: (ctx, idx) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: state.repositoryHistory.isNotEmpty
                              ? RepositoryItem(
                                  repositoryItem: null,
                                  isFavoriteScreen: false,
                                  repositoryHistory:
                                      state.repositoryHistory[idx],
                                )
                              : Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'You have empty history. Click on search to start journey!',
                                        style: WidgetHelper().getTextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
