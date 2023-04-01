import 'package:fashion_app/data/recommended_model.dart';
import 'package:fashion_app/data/trending_model.dart';

abstract class FashionDataAgent {
  // Trending for you api
  Future<List<TrendingModel>> getTrendingForYou();
  // Recommended api
  Future<List<RecommendedModel>> getRecommended();
}
