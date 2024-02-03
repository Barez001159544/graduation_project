class AuthRequest{
  late String username;
  late String password;

  AuthRequest(this.username, this.password);

  Map<String, dynamic> toJson()=>{
    'username': username,
    'password': password,
  };

  AuthRequest.fromJson(Map<String, dynamic> json){
    username= json['username'];
    password= json['password'];
  }
}