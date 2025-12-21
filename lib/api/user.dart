import 'package:hm_shop/constants/index.dart';
import 'package:hm_shop/utils/DioRequest.dart';
import 'package:hm_shop/viewmodels/user.dart';

Future<UserInfo> loginApi(Map<String, dynamic> data) async {
  return UserInfo.fromJSON(
    await dioRequest.post(HttpConstans.LOGIN, data: data),
  );
}

Future<UserInfo> getUserInfoApi() async {
  return UserInfo.fromJSON(await dioRequest.get(HttpConstans.USER_PROFILE));
}
