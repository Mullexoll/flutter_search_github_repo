import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_github_repo_flutter/constants/application_constants.dart';

class SplashScreenWidget extends StatelessWidget {
  const SplashScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: SearchAppConstants.primaryColor,
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                SearchAppConstants.splashScreenText,
                style: TextStyle(
                  color: SearchAppConstants.whiteColor,
                  fontFamily: 'Raleway',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  height: 16 / 18.78,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CupertinoActivityIndicator(
                color: SearchAppConstants.whiteColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
