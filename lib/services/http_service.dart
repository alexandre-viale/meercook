import 'package:http/http.dart';
import 'package:meercook/environment.dart';
import 'package:meercook/model/storer.dart';

Future<Response> customRequest({
  required Function requestMethod,
  required String path,
  bool useCredentials = true,
  Map<String, dynamic>? body,
}) async {
  Response response;
  try {
    Uri uri = Uri(
      host: Environment.apiHost,
      port: Environment.apiPort,
      path: '${Environment.apiPath}$path',
      scheme: 'http',
    );
    Map<String, String> headers = useCredentials
        ? {
            'Authorization': 'Bearer ${await Storer.getAccessToken()}',
          }
        : {};
    if (requestMethod == get) {
      response = await requestMethod(uri, headers: headers);
    } else {
      response = await requestMethod(
        uri,
        headers: headers,
        body: body,
      );
    }
    if (response.statusCode == 401) {
      await Storer.setAccessToken('');
    }
    return response;
  } catch (e) {
    print(e);
    return Response('', 500);
  }
}
