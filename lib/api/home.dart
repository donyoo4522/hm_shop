import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<List<BannerItem>> getBannerListApi() async {
  return ((await dioRequest.get(HttpConstans.BANNER_LIST)) as List).map((item) {
    return BannerItem.formJson(item as Map<String, dynamic>);
  }).toList();
}

// 获取首页分类列表
Future<List<CategoryItem>> getCategoryListApi() async {
  return ((await dioRequest.get(HttpConstans.CATEGORY_LIST)) as List).map((
    item,
  ) {
    return CategoryItem.formJson(item as Map<String, dynamic>);
  }).toList();
}

// 特惠推荐商品列表
Future<PromotionResult> getPromotionListApi() async {
  return PromotionResult.fromJson(
    await dioRequest.get(HttpConstans.PRODUCT_LIST),
  );
}

Future<PromotionResult> getInVogueListApi() async {
  return PromotionResult.fromJson(
    await dioRequest.get(HttpConstans.IN_VOGUE_LIST),
  );
}

Future<PromotionResult> getOneStopListApi() async {
  return PromotionResult.fromJson(
    await dioRequest.get(HttpConstans.ONE_STOP_LIST),
  );
}

// 推荐列表
Future<List<GoodDetailItem>> getRecommendListAPI(
  Map<String, dynamic> params,
) async {
  // 返回请求
  return ((await dioRequest.get(HttpConstans.RECOMMEND_LIST, params: params))
          as List)
      .map((item) {
        return GoodDetailItem.formJSON(item as Map<String, dynamic>);
      })
      .toList();
}
