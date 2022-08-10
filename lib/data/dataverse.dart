class AccountData {
  String? odataContext;
  List<Value>? value;

  AccountData({this.odataContext, this.value});

  AccountData.fromJson(Map<String, dynamic> json) {
    odataContext = json['@odata.context'];
    if (json['value'] != null) {
      value = <Value>[];
      json['value'].forEach((v) {
        value!.add( Value.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['@odata.context'] = this.odataContext;
    if (this.value != null) {
      data['value'] = this.value!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Value {
  String? odataEtag;
  String? accountid;
  String? name;
  String? accountnumber;
  int? statecode;
  String? address1Stateorprovince;
  String? entityimage;
  String? address1Composite;

  Value(
      {this.odataEtag,
      this.accountid,
      this.name,
      this.accountnumber,
      this.statecode,
      this.address1Stateorprovince,
      this.entityimage,
      this.address1Composite});

  Value.fromJson(Map<String, dynamic> json) {
    odataEtag = json['@odata.etag'];
    accountid = json['accountid'];
    name = json['name'];
    accountnumber = json['accountnumber'];
    statecode = json['statecode'];
    address1Stateorprovince = json['address1_stateorprovince'];
    entityimage = json['entityimage'];
    address1Composite = json['address1_composite'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['@odata.etag'] = this.odataEtag;
    data['accountid'] = this.accountid;
    data['name'] = this.name;
    data['accountnumber'] = this.accountnumber;
    data['statecode'] = this.statecode;
    data['address1_stateorprovince'] = this.address1Stateorprovince;
    data['entityimage'] = this.entityimage;
    data['address1_composite'] = this.address1Composite;
    return data;
  }
}
