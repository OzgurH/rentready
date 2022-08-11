import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dataverse.dart';
import 'globals.dart';



Future<AccountData>? fetchData() async {
  final http.Response response = await http.get(
    Uri.parse(apiurl),
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
