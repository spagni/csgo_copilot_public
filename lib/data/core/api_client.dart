import 'dart:convert';
import 'package:csgo_copilot/utils/exceptions/api_client_exception.dart';
import 'package:http/http.dart';
import 'api_constants.dart';

class ApiClient {
  final Client _client;

  ApiClient(this._client);

  Future<dynamic> get(
    String endpointPath, {
    String baseUrl,
    Map<String, String> params,
  }) async {
    var _baseUrl = baseUrl ?? ApiConstants.BASE_URL;

    Uri _uri = Uri.https(_baseUrl, endpointPath, params);

    final response = await _client.get(
      _uri,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      // throw Exception(response.reasonPhrase);
      throw ApiClientException(
        statusCode: response.statusCode,
        message: response.reasonPhrase,
      );
    }
  }
}
