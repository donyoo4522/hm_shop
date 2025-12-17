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
