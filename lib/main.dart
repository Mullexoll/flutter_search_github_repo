import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search_github_repo_flutter/bloc/repository_bloc.dart';

import 'presentation/ui/screens/search_screen.dart';
import 'presentation/ui/screens/splash_screen.dart';

void main() {
  runApp(const SearchApplication());
}

class SearchApplication extends StatelessWidget {
  const SearchApplication({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RepositoryBloc()
        ..add(
          NavigateToSearchScreenEvent(),
        ),
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Center(
        // Here I have used BlocBuilder, but instead you can also use BlocListner as well.
        child: BlocBuilder<RepositoryBloc, RepositoryState>(
          builder: (context, state) {
            if ((state is RepositoryInitial) || (state is RepositoryLoading)) {
              return const SplashScreenWidget();
            } else if (state is RepositoryLoaded) {
              return const SearchScreen();
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}
