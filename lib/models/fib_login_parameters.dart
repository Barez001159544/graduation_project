class FIBLoginParameters{
  late String grantType;
  late String id;
  late String secret;

  FIBLoginParameters(this.grantType, this.id, this.secret);

  Map<String, dynamic> toJson() => {
    "grant_type": grantType,
    "client_id": id,
    "client_secret": secret,
  };

  FIBLoginParameters.fromJson(Map<String, dynamic> json){
    grantType= json["grant_type"];
    id= json["client_id"];
    secret= json["client_secret"];
  }
}