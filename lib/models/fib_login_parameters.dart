class FIBLoginParameters{
  late String grantType;
  late String id;
  late String secret;

  FIBLoginParameters(this.grantType, this.id, this.secret);

  Map toJson()=>{
    "grant_type": grantType,
    "client_id": id,
    "client_secret": secret,
  };
}