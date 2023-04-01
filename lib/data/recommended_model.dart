// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

RecommendedModel recommendedModelFromJson(String str) =>
    RecommendedModel.fromJson(json.decode(str));

String recommendedModelToJson(RecommendedModel data) =>
    json.encode(data.toJson());

class RecommendedModel {
  RecommendedModel({
    this.id,
    this.title,
    this.image,
    this.color,
  });

  String? id;
  String? title;
  String? image;
  String? color;

  factory RecommendedModel.fromJson(Map<String, dynamic> json) =>
      RecommendedModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "color": color,
      };

  @override
  String toString() =>
      'RecommendedModel(id: $id, title: $title, image: $image, color: $color)';
}
