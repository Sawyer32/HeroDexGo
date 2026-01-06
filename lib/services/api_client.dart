import 'dart:convert';

import 'package:hero_dex_go/models/hero_models.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  static const String _accessToken = 'abc52c436aa08adc16b0fbc4c12a7e85';
  static const String _baseUrl = 'https://superheroapi.com/api/$_accessToken';

  final http.Client _httpClient;

  ApiClient({http.Client? httpClient}) : _httpClient = httpClient ?? http.Client();

  Future<List<HeroModel>> searchHeroes(String query) async {
    try {
      final uri = Uri.parse('$_baseUrl/search/$query');
      final response = await _httpClient.get(uri);

      if (response.statusCode != 200) {
        throw Exception('Failed to load heroes. Status: ${response.statusCode}');
      }

      final Map<String, dynamic> data = jsonDecode(response.body);

      if (data['response'] == 'error') {
        return [];
      }

      final List<dynamic> results = data['results'];

      return results.map((json) {
        return HeroModel.fromJson(json);
      }).toList();
      
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}