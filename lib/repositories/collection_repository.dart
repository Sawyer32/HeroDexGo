import 'package:hero_dex_go/models/hero_models.dart';
import 'package:hero_dex_go/services/api_client.dart';

class CollectionRepository {
  final ApiClient _apiClient;

  CollectionRepository({ApiClient? apiClient})
    : _apiClient = apiClient ?? ApiClient();

  Future<List<HeroModel>> getCollection() async {
    return _apiClient.getUserCollection();
  }

  Future<void> addToCollection(String heroId) async {
    return _apiClient.addHeroToCollection(heroId);
  }

  Future<void> removeHeroFromCollection(String heroId) async {
    return _apiClient.removeHeroFromCollection(heroId);
  }

  Future<bool> isHeroInCollection(String heroId) async {
    return _apiClient.isHeroInCollection(heroId);
  }
}
