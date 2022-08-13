import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dataverse.dart';
import 'globals.dart';

DateTime lastTokenFetchDate = DateTime.now()
    .add(const Duration(minutes: (-1 * (tokenRefreshIntervalInMinutes + 1))));
// default value ise 1 minute less than token refresh interval to get the token in first run.

Future<AccountData>? fetchData() async {
  String endPoint = apiurl;

  //Search and filtering params on endpoint url
  if (searchtext != '') {
    endPoint =
        '$apiurl&\$filter=(contains(name,\'$searchtext\') or contains(accountnumber,\'$searchtext\'))';
  }

  if (filter != '') {
    endPoint = '$apiurl$filter';
  }

  if (kDebugMode) {
    print('request:$endPoint');
  }

  //Refresh the token if its expired.
  (DateTime.now().difference(lastTokenFetchDate).inMinutes >=
          tokenRefreshIntervalInMinutes)
      ? await refreshToken()
      : null;

  //Retrieve the data from endpoint
  final http.Response response = await http.get(
    Uri.parse(endPoint),
    headers: {"Authorization": "Bearer $token"},
  );

  //Convert result JSON to AccountData Class
  if (response.statusCode == 200) {
    final jsonResponse = AccountData.fromJson(jsonDecode(response.body));
    return jsonResponse;
  } else {
    throw Exception(
      "Request failed: ${response.statusCode}",
    );
  }
}

Future<void> refreshToken() async {
  //Dataverse token is providing from backend, because of Microsoft Authentication Library (MSAL) support.
  //Its possible to authenticate MSAL in flutter by 3rd party components but it requires extra effort.
  //We primarily focused the requirements on the assignment.
  token = await http.read(Uri.parse('https://tourwise.app/token.txt'));
  lastTokenFetchDate = DateTime.now();
}
