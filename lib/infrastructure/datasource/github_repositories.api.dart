import 'dart:convert' show json, utf8;
import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:search_github_repo_flutter/domain/models/repository_model_item.dart';

class Api {
  static final HttpClient _httpClient = HttpClient();
  static const String _url = "api.github.com";

  static Future<List<RepositoryModel>?> getRepositoriesWithSearchQuery(
      String query) async {
    final uri = Uri.https(_url, '/search/repositories', {
      'q': query,
      'sort': 'stars',
      'order': 'desc',
      'page': '0',
      'per_page': '15'
    });

    final jsonResponse = await _getJson(uri);

    if (jsonResponse['errors'] != null) {
      return null;
    }
    if (jsonResponse['items'] == null) {
      return List.from([]);
    }

    return RepositoryModel.mapJSONStringToList(jsonResponse['items']);
  }

  static Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        return {};
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();

      return json.decode(responseBody);
    } on Exception catch (e) {
      debugPrint('$e');

      return {};
    }
  }
}
