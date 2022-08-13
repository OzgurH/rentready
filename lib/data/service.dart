import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dataverse.dart';
import 'globals.dart';

Future<AccountData>? fetchData() async {
  String endPoint = apiurl;

  if (searchtext != '') {
    endPoint =
        '$apiurl&\$filter=(contains(name,\'$searchtext\') or contains(accountnumber,\'$searchtext\'))';
  }

  if (filter != '') {
    endPoint = '$apiurl$filter';
  }

  if (kDebugMode) {
    print('request:' + endPoint);
  }

  final http.Response response = await http.get(
    Uri.parse(endPoint),
    headers: {
      "Authorization": "Bearer $token",
      "Cookie": cookie,
    },
  );

  if (response.statusCode == 200) {
    final jsonResponse = AccountData.fromJson(jsonDecode(response.body));
    return jsonResponse;
  } else {
    throw Exception(
      "Request failed: ${response.statusCode}",
    );
  }
}
