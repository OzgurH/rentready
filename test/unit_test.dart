import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:rentready/data/dataverse.dart';
import 'package:rentready/data/globals.dart';

import 'package:rentready/data/service.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([http.Client])
void main() {
  String responseString =
      '{ "@odata.context": "https://org46c7a9ce.api.crm4.dynamics.com/api/data/v9.2/\$metadata#accounts(accountid,name,accountnumber,statecode,address1_stateorprovince,entityimage)", "value": [ { "@odata.etag": "W/\\"3146260\\"", "accountid": "88019079-e334-46c0-b2da-27d8a73c51dc", "name": "Cafe Duo", "accountnumber": "3006", "statecode": 0, "address1_stateorprovince": "WA", "entityimage": null, "address1_composite": "WA" }, { "@odata.etag": "W/\\"3146264\\"", "accountid": "dbdd0b93-4a1b-4848-b83a-39352f6b2e7a", "name": "Fourth Coffee", "accountnumber": "2020", "statecode": 0, "address1_stateorprovince": "WA", "entityimage": null, "address1_composite": "WA" }, { "@odata.etag": "W/\\"3146267\\"", "accountid": "0faa50fe-e7d0-4e9d-bdfd-3aacc2d9cbdd", "name": "Contoso Coffee", "accountnumber": "2017", "statecode": 0, "address1_stateorprovince": "WA", "entityimage": null, "address1_composite": "WA" }, { "@odata.etag": "W/\\"3146268\\"", "accountid": "bda958a1-7ff7-4f69-9812-83d77efe0cc8", "name": "Bean-to-Cup Machines", "accountnumber": "3011", "statecode": 0, "address1_stateorprovince": "WA", "entityimage": null, "address1_composite": "WA" } ] }';
  group('JSON data tests', () {
    test('Bind account data from json', () {
      AccountData accounts = AccountData.fromJson(jsonDecode(responseString));
      expect(accounts.value!.length, greaterThan(0));
    });
  });

  group('fetchData', () {
    test('returns Accounts if the http call completes successfully', () async {
      var client = MockClient((request) async {
        return Response(json.encode(request.bodyFields), 200, request: request);
      });

      var response =
          await client.post(Uri.parse(apiurl), body: {"json": responseString});

      expect(response.body, contains("Cafe Duo"));
    });
  });
}
