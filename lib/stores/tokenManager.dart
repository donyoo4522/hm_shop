import 'package:hm_shop/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  Future<SharedPreferences> _getInstance() {
    return SharedPreferences.getInstance();
  }

  String _token = "";
  init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstans.TOKEN_KEY) ?? "";
  }

  Future<void> setToken(String val) async {
    final prefs = await _getInstance();
    prefs.setString(GlobalConstans.TOKEN_KEY, val);
    _token = val;
  }

  String getToken() {
    return _token;
  }

  removeToken() async {
    final prefs = await _getInstance();
    prefs.remove(GlobalConstans.TOKEN_KEY);
    _token = "";
  }
}

final tokenManager = TokenManager();
