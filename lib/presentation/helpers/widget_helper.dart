import 'package:flutter/material.dart';
import 'package:search_github_repo_flutter/constants/application_constants.dart';

class WidgetHelper {
  TextStyle getTextStyle({
    required double? fontSize,
    required FontWeight? fontWeight,
  }) {
    return TextStyle(
      color: SearchAppConstants.primaryTextColor,
      fontFamily: 'Raleway',
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: fontSize,
      height: 16 / 18.78,
    );
  }
}
