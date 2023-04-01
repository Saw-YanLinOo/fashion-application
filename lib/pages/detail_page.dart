import 'package:fashion_app/data/recommended_model.dart';
import 'package:fashion_app/data/trending_model.dart';
import 'package:fashion_app/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({
    super.key,
    this.trendingModel,
    this.recommendedList,
  });

  final TrendingModel? trendingModel;
  final List<RecommendedModel>? recommendedList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            bottom: PreferredSize(
              child: SizedBox(),
              preferredSize: Size(0, 20),
            ),
            flexibleSpace: Stack(
              children: [
                Positioned.fill(
                  child: Image.network(
                    '${trendingModel?.image}',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
                  right: 10,
                  left: 10,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 32,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        FontAwesomeIcons.solidHeart,
                        color: Colors.white,
                        size: 32,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(
                        Icons.share,
                        size: 32,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -10,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                  height: 20,
                ),
                GeneralSection(
                  trendingModel: trendingModel,
                ),
                SizedBox(
                  height: 8,
                ),
                DescriptionSection(
                  description: trendingModel?.description,
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedSection(
                    trendingModel: trendingModel,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TitleAndItemView(
                    title: "Related outfit",
                    recommendedList: recommendedList,
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SizedSection extends StatelessWidget {
  const SizedSection({
    super.key,
    this.trendingModel,
  });

  final TrendingModel? trendingModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Sizes',
              style: TextStyle(
                fontWeight: FontWeight.w700,
              ),
            ),
            Spacer(),
            Text(
              'Size Guide',
              style: TextStyle(
                color: Colors.indigo,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 8,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: trendingModel?.sizes?.map((e) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: SizeItemView(text: '$e'),
                );
              }).toList() ??
              [],
        ),
      ],
    );
  }
}

class SizeItemView extends StatelessWidget {
  const SizeItemView({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          "$text",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class DescriptionSection extends StatelessWidget {
  const DescriptionSection({
    super.key,
    this.description,
  });

  final String? description;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Descriptions',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w700,
        ),
      ),
      childrenPadding: EdgeInsets.symmetric(horizontal: 20),
      shape: Border.all(style: BorderStyle.none),
      initiallyExpanded: true,
      children: [
        Text(
          '${description}',
          maxLines: 8,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
          ),
        )
      ],
    );
  }
}

class GeneralSection extends StatelessWidget {
  const GeneralSection({
    super.key,
    this.trendingModel,
  });

  final TrendingModel? trendingModel;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'OUTFIT IDEAS',
          style: TextStyle(
            color: Colors.grey,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '${trendingModel?.name}',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 24,
          ),
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          '\$${trendingModel?.price}',
          style: TextStyle(
            color: Colors.indigo,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
