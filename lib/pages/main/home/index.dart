import 'package:flutter/material.dart';
import 'package:hm_shop/api/home.dart';
import 'package:hm_shop/components/home/hmCategory.dart';
import 'package:hm_shop/components/home/hmHot.dart';
import 'package:hm_shop/components/home/hmMoreList.dart';
import 'package:hm_shop/components/home/hmSlider.dart';
import 'package:hm_shop/components/home/hmSuggention.dart';
import 'package:hm_shop/utils/Toast.dart';
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

  int _page = 1;
  bool _isLoding = false;
  bool _hasMore = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _registerEvent();
    Future.microtask(() {
      _paddingTop = 100;
      setState(() {});
      _key.currentState?.show();
    });
  }

  void _registerEvent() {
    _controller.addListener(() {
      if (_controller.position.pixels >=
          (_controller.position.maxScrollExtent - 50)) {
        // 当滚动到接近底部时，加载更多数据
        _getRecommendList();
      }
    });
  }

  // 获取推荐列表
  Future<void> _getRecommendList() async {
    if (_isLoding || !_hasMore) {
      return;
    }
    _isLoding = true;
    int requireLimit = _page * 8;
    _recommendList = await getRecommendListAPI({"limit": requireLimit});
    _isLoding = false;
    setState(() {});
    if (_recommendList.length < requireLimit) {
      _hasMore = false;
      return;
    }

    _page++;
  }

  Future<void> _getInVogeList() async {
    _inVogueResult = await getInVogueListApi();
    setState(() {});
  }

  Future<void> _getOneStopList() async {
    _oneStopResult = await getOneStopListApi();
    setState(() {});
  }

  // 特惠推荐
  Future<void> _getPromotionList() async {
    _promotionResult = await getPromotionListApi();
    setState(() {});
  }

  // 获取首页分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListApi();
    setState(() {});
  }

  Future<void> _getBannerList() async {
    _bannerList = await getBannerListApi();
    setState(() {});
  }

  Future<void> _onRefresh() async {
    _page = 1;
    _isLoding = false;
    _hasMore = true;
    await _getBannerList();
    await _getCategoryList();
    await _getPromotionList();
    await _getInVogeList();
    await _getOneStopList();
    await _getRecommendList();
    Toast.showToast(context, "刷新成功");
    _paddingTop = 0;
    setState(() {});
  }

  final ScrollController _controller = ScrollController();

  final GlobalKey<RefreshIndicatorState> _key =
      GlobalKey<RefreshIndicatorState>();
  double _paddingTop = 0;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _key,
      onRefresh: _onRefresh,
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          controller: _controller,
          slivers: _getScrollChildren(),
        ),
      ),
    );
  }
}
