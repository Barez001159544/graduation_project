class AuthResponse{
  late String name;
  late String email;
  late String phoneNumber;
  late String buildingNumber;
  late String imgUrl;

  AuthResponse(this.name, this.email, this.phoneNumber, this.buildingNumber, this.imgUrl);

  Map<String, dynamic> toJson()=>{
    'name': name,
    'email': email,
    'phoneNumber': phoneNumber,
    'buildingNumber': buildingNumber,
    'imgUrl': imgUrl,
  };
  
  AuthResponse.fromJson(Map<String, dynamic> json){
    name= json['name'];
    email= json['email'];
    phoneNumber= json['phoneNumber'];
    buildingNumber= json['buildingNumber'];
    imgUrl= json['imgUrl'];
  }
}