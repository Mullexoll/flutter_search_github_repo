import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_github_repo_flutter/bloc/repository_bloc.dart';
import 'package:search_github_repo_flutter/constants/application_constants.dart';
import 'package:search_github_repo_flutter/domain/models/repository_model_item.dart';
import 'package:search_github_repo_flutter/domain/models/search_repository_history.dart';
import 'package:search_github_repo_flutter/presentation/helpers/widget_helper.dart';

class RepositoryItem extends StatefulWidget {
  final RepositoryModel? repositoryItem;
  final SearchRepositoryHistory? repositoryHistory;
  final bool isFavoriteScreen;

  const RepositoryItem({
    super.key,
    required this.repositoryItem,
    required this.isFavoriteScreen,
    this.repositoryHistory,
  });

  @override
  State<RepositoryItem> createState() => _RepositoryItemState();
}

class _RepositoryItemState extends State<RepositoryItem> {
  bool isFavorite = false;

  addRepositoryToFavorite(BuildContext context) {
    setState(() {
      isFavorite = !isFavorite;
    });
    final RepositoryBloc repositoryBloc =
        BlocProvider.of<RepositoryBloc>(context);
    if (widget.repositoryItem != null) {
      final _ = repositoryBloc.add(
        AddRepositoryToFavoriteEvent(widget.repositoryItem!),
      );
    } else {
      final _ = repositoryBloc.add(
        AddRepositoryHistoryItemToFavoriteEvent(
          widget.repositoryHistory!,
        ),
      );
    }
  }

  deleteRepositoryHistoryItem(BuildContext context) {
    final RepositoryBloc repositoryBloc =
        BlocProvider.of<RepositoryBloc>(context);

    final _ = repositoryBloc.add(
      RemoveRepositoryHistoryItemEvent(widget.repositoryHistory!),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 361,
      height: 55,
      constraints: const BoxConstraints(
        maxWidth: 361,
        maxHeight: 55,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(
            242, 242, 242, 1), // Use the desired color code
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              widget.repositoryHistory == null
                  ? widget.repositoryItem!.name
                  : widget.repositoryHistory!.name,
              style: WidgetHelper().getTextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          //TODO: using for delete history item

          // if (widget.repositoryItem == null)
          //   InkWell(
          //     onTap: () => deleteRepositoryHistoryItem(context),
          //     child: const Icon(
          //       Icons.delete,
          //       size: 24,
          //       color: SearchAppConstants.primaryColor,
          //     ),
          //   ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () => addRepositoryToFavorite(context),
              child: SvgPicture.asset(
                'assets/icons/favorite_star_icon.svg',
                width: 24,
                height: 24,
                fit: BoxFit.none,
                colorFilter: widget.repositoryHistory != null
                    ? ColorFilter.mode(
                        widget.repositoryHistory!.isFavorite
                            ? SearchAppConstants.primaryColor
                            : SearchAppConstants.placeholderColor,
                        BlendMode.srcIn,
                      )
                    : ColorFilter.mode(
                        widget.isFavoriteScreen
                            ? widget.repositoryItem!.isFavorite
                                ? SearchAppConstants.primaryColor
                                : SearchAppConstants.placeholderColor
                            : isFavorite
                                ? SearchAppConstants.primaryColor
                                : SearchAppConstants.placeholderColor,
                        BlendMode.srcIn,
                      ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
