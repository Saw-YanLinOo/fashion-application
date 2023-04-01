import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fashion_app/data/trending_model.dart';
import 'package:fashion_app/data/recommended_model.dart';
import 'package:fashion_app/network/api_constant.dart';
import 'package:fashion_app/network/dataagent/fashion_data_agent.dart';

class DioDataAgentImpl extends FashionDataAgent {
  late Dio _dio;

  DioDataAgentImpl.singleton() {
    _dio = Dio();
  }

  static final DioDataAgentImpl _singleton = DioDataAgentImpl.singleton();

  factory DioDataAgentImpl() {
    return _singleton;
  }

  @override
  Future<List<RecommendedModel>> getRecommended() {
    return _dio.get(GET_RECOMMENDED).then((value) {
      return (jsonDecode(value.data) as List<dynamic>)
          .map((e) => RecommendedModel.fromJson(e))
          .toList();
    });
  }

  @override
  Future<List<TrendingModel>> getTrendingForYou() {
    return _dio.get(GET_TRENDING_FOR_YOU).then((value) {
      return (jsonDecode(value.data) as List<dynamic>)
          .map((e) => TrendingModel.fromJson(e))
          .toList();
    });
  }
}
