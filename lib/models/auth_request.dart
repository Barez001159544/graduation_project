class AuthRequest{
  late String email;
  late String password;

  AuthRequest(this.email, this.password);

  Map<String, dynamic> toJson()=>{
    'email': email,
    'password': password,
  };

  AuthRequest.fromJson(Map<String, dynamic> json){
    email= json['email'];
    password= json['password'];
  }
}