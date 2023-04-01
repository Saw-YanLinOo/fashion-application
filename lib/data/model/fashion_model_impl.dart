import 'package:fashion_app/data/model/fashion_model.dart';
import 'package:fashion_app/data/trending_model.dart';
import 'package:fashion_app/data/recommended_model.dart';
import 'package:fashion_app/network/dataagent/dio_data_agent_impl.dart';
import 'package:fashion_app/network/dataagent/fashion_data_agent.dart';

class FashionModelImpl extends FashionModel {
  FashionModelImpl.singleton();

  static final FashionModelImpl _singleton = FashionModelImpl.singleton();

  factory FashionModelImpl() => _singleton;

  // Network Data Agent
  final FashionDataAgent _dataAgent = DioDataAgentImpl();

  @override
  Future<List<RecommendedModel>> getRecommended() {
    return _dataAgent.getRecommended();
  }

  @override
  Future<List<TrendingModel>> getTrendingForYou() {
    return _dataAgent.getTrendingForYou();
  }
}
