import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hero_dex_go/models/hero_models.dart';
import 'package:hero_dex_go/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SearchRepository {
  final Map<String, List<HeroModel>> _cache = {};
  final ApiClient _apiClient;
  final SharedPreferences _prefs;

  static const String _historyKey = 'search_history';

  SearchRepository({
    required ApiClient apiClient,
    required SharedPreferences prefs,
  }) : _apiClient = apiClient,
       _prefs = prefs;

  Future<List<HeroModel>> search(String query) async {
    if (_cache.containsKey(query)) {
      debugPrint("Fetching $query from cache");
      return _cache[query]!;
    }

    final results = await _apiClient.searchHeroes(query);

    _cache[query] = results;

    return results;
  }

  Future<void> saveSearchHistory(List<String> history) async {
    await _prefs.setStringList(_historyKey, history);
  }

  List<String> getSearchHistory() {
    return _prefs.getStringList(_historyKey) ?? [];
  }
}
