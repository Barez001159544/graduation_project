class FIBLoginResponse{
  late String accessToken;
  late int expiresIn;
  late int refreshExpiresIn;
  late String refreshToken;
  late String tokenType;
  late int notBeforePolicy;
  late String sessionState;
  late String scope;

  FIBLoginResponse(
      this.accessToken,
      this.expiresIn,
      this.refreshExpiresIn,
      this.refreshToken,
      this.tokenType,
      this.notBeforePolicy,
      this.sessionState,
      this.scope
      );

  FIBLoginResponse.fromJson(Map<String, dynamic> json){
    accessToken= json["access_token"];
    expiresIn= json["expires_in"];
    refreshExpiresIn= json["refresh_expires_in"];
    // refreshToken= json["refresh_token"];
    tokenType= json["token_type"];
    notBeforePolicy= json["not-before-policy"];
    // sessionState= json["session_state"];
    scope= json["scope"];
  }
}