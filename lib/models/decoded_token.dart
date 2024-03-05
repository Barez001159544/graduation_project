class DecodedToken{
  late String name;
  late String email;
  late String password;
  late String phoneNumber;
  late String picture;
  late int age;
  late String jobTitle;
  late String role;
  // late String buildingNumber;
  // late String imgUrl;

  DecodedToken(this.name, this.email, this.password, this.phoneNumber, this.age, this.jobTitle, this.role);

  Map<String, dynamic> toJson()=>{
    'name': name,
    'email': email,
    'password': password,
    'phoneNumber': phoneNumber,
    'picture': picture,
    'age': age,
    'job_title': jobTitle,
    'role': role,
  };

  DecodedToken.fromJson(Map<String, dynamic> json){
    name= json['name'];
    email= json['email'];
    password= json['password'];
    phoneNumber= json['phoneNumber'];
    picture= json['picture'];
    age= json['age'];
    jobTitle= json['job_title'];
    role= json['role'];
  }
}