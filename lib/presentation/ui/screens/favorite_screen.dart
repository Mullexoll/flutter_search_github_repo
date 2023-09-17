import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../bloc/repository_bloc.dart';
import '../../../constants/application_constants.dart';
import '../../helpers/widget_helper.dart';
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
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(76),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
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
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              'Favorite repos list',
                              textAlign: TextAlign.center,
                              style: WidgetHelper().getTextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
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
                            color: Color.fromRGBO(
                                0, 0, 0, 0.03), // Box shadow color
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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView.builder(
                itemCount:
                    (state as RepositoryLoaded).favoriteRepositories.length,
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
            ),
          ),
        );
      },
    );
  }
}
