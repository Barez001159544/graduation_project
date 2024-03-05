
class AuthResponse{
  late String status;
  late String bearerToken;

  AuthResponse(this.status, this.bearerToken);

  Map<String, dynamic> toJson()=>{
    'status': status,
    'bearer_token': bearerToken,
  };
  
  AuthResponse.fromJson(Map<String, dynamic> json){
    status= json['status'];
    bearerToken= json['bearer_token'];
  }
}

