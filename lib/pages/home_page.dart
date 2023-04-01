import 'package:fashion_app/data/model/fashion_model.dart';
import 'package:fashion_app/data/model/fashion_model_impl.dart';
import 'package:fashion_app/data/recommended_model.dart';
import 'package:fashion_app/data/trending_model.dart';
import 'package:fashion_app/extensions/colors.dart';
import 'package:fashion_app/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FashionModel _model = FashionModelImpl();

  List<TrendingModel>? trendingList;
  List<RecommendedModel>? recommendedList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //get trending for you
    _model.getTrendingForYou().then((value) {
      trendingList = value;

      print(trendingList);
      setState(() {});
    });

    // get recommended
    _model.getRecommended().then((value) {
      recommendedList = value;
      print(recommendedList);
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                child: HomeAppBarSection(),
              ),
              SizedBox(
                height: 24,
              ),
              TrendingForYouSection(
                trendingList: trendingList,
                onTap: (trendingModel) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailPage(
                        trendingModel: trendingModel,
                        recommendedList: recommendedList,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TitleAndItemView(
                  title: "Recommended",
                  recommendedList: recommendedList,
                ),
              ),
              SizedBox(
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TitleAndItemView extends StatelessWidget {
  const TitleAndItemView({
    super.key,
    this.title,
    this.recommendedList,
  });

  final String? title;
  final List<RecommendedModel>? recommendedList;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              '$title',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Text(
              '...',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 16,
        ),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: recommendedList?.map((e) {
                return RecommendedItemView(
                    title: '${e.title}',
                    image: '${e.image}',
                    color: '${e.color}'.toColor());
              }).toList() ??
              [],
        ),
      ],
    );
  }
}

class RecommendedItemView extends StatelessWidget {
  const RecommendedItemView({
    super.key,
    required this.title,
    required this.image,
    required this.color,
  });

  final String title;
  final String image;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color.withOpacity(.2),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            child: Image.network(image),
          ),
          Text(
            title,
            style: TextStyle(
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

class TrendingForYouSection extends StatelessWidget {
  const TrendingForYouSection({
    super.key,
    this.trendingList,
    required this.onTap,
  });

  final List<TrendingModel>? trendingList;
  final Function(TrendingModel?) onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Text(
                'Trending For You',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                '...',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: MediaQuery.of(context).size.height / 2,
          child: ListView.separated(
            itemCount: trendingList?.length ?? 0,
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemBuilder: (context, index) {
              var trending = trendingList?[index];

              return TrendingItemView(
                onTap: () {
                  onTap(trending);
                },
                trending: trending,
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                width: 20,
              );
            },
          ),
        ),
      ],
    );
  }
}

class TrendingItemView extends StatelessWidget {
  const TrendingItemView({
    super.key,
    this.trending,
    required this.onTap,
  });

  final TrendingModel? trending;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.1,
        height: MediaQuery.of(context).size.height / 2,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                '${trending?.image}',
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              top: 15,
              right: 15,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.pink.shade100,
                ),
                padding: EdgeInsets.all(8),
                child: Icon(
                  FontAwesomeIcons.heart,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned(
              bottom: 15,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${trending?.category}',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.pink.shade100,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 2,
                    child: Text(
                      '${trending?.name}',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.network(
                          "${trending?.userProfile}",
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '${trending?.userName}',
                        style: TextStyle(
                          color: Colors.pink.shade100,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeAppBarSection extends StatelessWidget {
  const HomeAppBarSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            "assets/profile.png",
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          width: 8,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hawdy',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Christia Yota',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        Spacer(),
        Icon(
          Icons.notifications,
          size: 32,
        ),
      ],
    );
  }
}
