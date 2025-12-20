import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/home.dart';

Future<GoodsDetailsItems> getGuesssListApi(Map<String, dynamic> params) async {
  return GoodsDetailsItems.fromJson(
    await dioRequest.get(HttpConstans.GUESS_LIST, params: params),
  );
}
