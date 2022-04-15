import 'package:localstorage/localstorage.dart';

class Storer {
  static final LocalStorage storage = LocalStorage('meercook');
  static String accessToken = '';
  Storer();

  static setAccessToken(String accessToken) async {
    try {
      await storage.ready;
      storage.setItem('accessToken', accessToken);
      Storer.accessToken = accessToken;
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getAccessToken() async {
    if (accessToken != '') {
      return accessToken;
    }

    try {
      await storage.ready;
      accessToken = storage.getItem('accessToken') ?? '';
      return accessToken;
    } catch (e) {
      rethrow;
    }
  }
}
