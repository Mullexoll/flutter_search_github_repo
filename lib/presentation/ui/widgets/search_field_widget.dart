import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:search_github_repo_flutter/bloc/repository_bloc.dart';
import 'package:search_github_repo_flutter/constants/application_constants.dart';
import 'package:search_github_repo_flutter/domain/models/repository_model_item.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  CustomSearchBarState createState() => CustomSearchBarState();
}

class CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _textController = TextEditingController();
  List<RepositoryModel> results = List.from([]);

  CustomSearchBarState();

  _onSearchBarSubmitted(String value, RepositoryBloc repositoryBloc) {
    final _ = repositoryBloc.add(PerformSearchEvent(value));

    setState(() {
      _textController.text = value;
    });
  }

  _onSearchBarChanged(String value) {
    setState(() {
      _textController.text = value;
    });
  }

  clearSearchBar(RepositoryBloc repositoryBloc) {
    _textController.clear();
    repositoryBloc.add(ClearFetchedRepositoriesEvent());
  }

  @override
  Widget build(BuildContext context) {
    final RepositoryBloc repositoryBloc =
        BlocProvider.of<RepositoryBloc>(context);

    return SearchBar(
      controller: _textController,
      backgroundColor: MaterialStateProperty.all(
        const Color.fromRGBO(242, 242, 242, 1),
      ),
      overlayColor: MaterialStateProperty.all(
        const Color.fromRGBO(229, 237, 255, 1),
      ),
      side: MaterialStateProperty.all(
        _textController.text != ''
            ? const BorderSide(
                color: SearchAppConstants.primaryColor,
              )
            : BorderSide.none,
      ),
      hintText: 'Search',
      hintStyle: MaterialStateProperty.all(
        const TextStyle(
          color: Color.fromRGBO(191, 191, 191, 1),
        ),
      ),
      onSubmitted: (String value) =>
          _onSearchBarSubmitted(value, repositoryBloc),
      onChanged: (String value) => _onSearchBarChanged(value),
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: SvgPicture.asset(
          'assets/icons/search_icon.svg',
          width: 24,
          height: 24,
          fit: BoxFit.none,
        ),
      ),
      trailing: [
        if (_textController.text != '')
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: InkWell(
              onTap: () => clearSearchBar(repositoryBloc),
              child: SvgPicture.asset(
                'assets/icons/close_icon.svg',
                width: 24,
                height: 24,
                fit: BoxFit.none,
              ),
            ),
          )
      ],
    );
  }
}
