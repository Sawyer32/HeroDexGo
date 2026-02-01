import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hero_dex_go/models/hero_models.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String _accessToken = 'abc52c436aa08adc16b0fbc4c12a7e85';
  static const String _baseUrl =
      'https://www.superheroapi.com/api.php/$_accessToken';

  final http.Client _httpClient;

  ApiClient({http.Client? httpClient})
    : _httpClient = httpClient ?? http.Client();

  Future<List<HeroModel>> searchHeroes(String query) async {
    try {
      final db = FirebaseFirestore.instance;

      final snapshot = await db
          .collection('heroes')
          .where('name', isGreaterThanOrEqualTo: query)
          .where('name', isLessThan: '${query}z')
          .get();

      final List<HeroModel> heroes = snapshot.docs
          .map((doc) => HeroModel.fromJson(doc.data()))
          .toList();

      final filteredHeroes = heroes
          .where(
            (hero) => hero.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();

      if (filteredHeroes.isNotEmpty) {
        debugPrint("Fetching $query from DB");
        return filteredHeroes;
      }

      debugPrint("Fetching $query from API");

      final uri = Uri.parse('$_baseUrl/search/${Uri.encodeComponent(query)}');
      debugPrint("Requesting URI: $uri");

      final response = await _httpClient.get(uri);
      debugPrint("Response status: ${response.statusCode}");

      if (response.statusCode != 200) {
        throw Exception(
          'Failed to load heroes. Status: ${response.statusCode}',
        );
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['response'] == 'error') {
        debugPrint("API Error: ${data['error']}");
        return [];
      }

      final List<dynamic> results = data['results'];

      saveHeroToDb(
        results.map((json) => HeroModel.fromJson(json)).toList(),
      ).ignore();

      return results.map((json) {
        return HeroModel.fromJson(json);
      }).toList();
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<HeroModel> getHeroById(String id) async {
    try {
      final uri = Uri.parse('$_baseUrl/$id');
      final response = await _httpClient.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Failed to load hero. Status: ${response.statusCode}');
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['response'] == 'error') {
        throw Exception('Failed to load hero. Error: ${data['error']}');
      }

      return HeroModel.fromJson(data);
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<List<HeroModel>> saveHeroToDb(List<HeroModel> heroes) async {
    try {
      final db = FirebaseFirestore.instance;
      final batch = db.batch();
      for (final hero in heroes) {
        final docRef = db.collection('heroes').doc(hero.id);
        batch.set(docRef, hero.toJson(), SetOptions(merge: true));
      }
      await batch.commit();
      return heroes;
    } catch (e) {
      throw Exception('Failed to save hero to DB: $e');
    }
  }
}
