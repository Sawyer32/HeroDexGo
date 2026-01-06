import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hero_dex_go/models/hero_models.dart';
import 'package:hero_dex_go/services/api_client.dart';
import 'package:http/http.dart' as http;

class SearchRepository {
  final Map<String, List<HeroModel>> _cache = {};
  final ApiClient _apiClient;

  SearchRepository({required ApiClient apiClient}) : _apiClient = apiClient;

  Future<List<HeroModel>> search(String query) async {
    if (_cache.containsKey(query)) {
      debugPrint("Fetching $query from cache");
      return _cache[query]!;
    }

    debugPrint("Fetching $query from API");
    final results = await _apiClient.searchHeroes(query);

    _cache[query] = results;

    return results;
  }
}