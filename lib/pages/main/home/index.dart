import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/home/hmCategory.dart';
import 'package:hm_shop/components/home/hmHot.dart';
import 'package:hm_shop/components/home/hmMoreList.dart';
import 'package:hm_shop/components/home/hmSlider.dart';
import 'package:hm_shop/components/home/hmSuggention.dart';
import 'package:hm_shop/viewmodels/home.dart';

class HomeView extends StatefulWidget {
  HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  List<CategoryItem> _categoryList = [];
  List<BannerItem> _bannerList = [
    // BannerItem(
    //   id: "1",
    //   imgUrl: "https://vcg00.cfp.cn/creative/vcg/800/new/VCG41N1094915042.jpg",
    // ),
    // BannerItem(
    //   id: "2",
    //   imgUrl: "https://vcg00.cfp.cn/creative/vcg/800/new/VCG211414683666.jpg",
    // ),
    // BannerItem(
    //   id: "3",
    //   imgUrl: "https://vcg00.cfp.cn/creative/vcg/800/new/VCG41N1471931858.jpg",
    // ),
  ];
  List<Widget> _getScrollChildren() {
    return [
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: HmSuggention(promotionResult: _promotionResult),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(result: _inVogueResult, type: "hot"),
              ),
              SizedBox(width: 10),
              Expanded(
                child: HmHot(result: _oneStopResult, type: "step"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      HmMoreList(recommendList: _recommendList), // 无限滚动列表
    ];
  }

  // 特惠推荐
  PromotionResult _promotionResult = PromotionResult(
    id: "",
    title: "",
    subTypes: [],
  );

  PromotionResult _inVogueResult = PromotionResult(
    id: "",
    title: "",
    subTypes: [],
  );
  PromotionResult _oneStopResult = PromotionResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 推荐列表
  List<GoodDetailItem> _recommendList = [];

  // 获取推荐列表
  void _getRecommendList() async {
    _recommendList = await getRecommendListAPI({"limit": 10});
    setState(() {});
  }

  void _getInVogeList() async {
    _inVogueResult = await getInVogueListApi();
    setState(() {});
  }

  void _getOneStopList() async {
    _oneStopResult = await getOneStopListApi();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getBannerList();
    _getCategoryList();
    _getPromotionList();
    _getInVogeList();
    _getOneStopList();
    _getRecommendList();
  }

  // 特惠推荐
  void _getPromotionList() async {
    _promotionResult = await getPromotionListApi();
    setState(() {});
  }

  // 获取首页分类列表
  void _getCategoryList() async {
    _categoryList = await getCategoryListApi();
    setState(() {});
  }

  void _getBannerList() async {
    _bannerList = await getBannerListApi();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: _getScrollChildren());
  }
}
