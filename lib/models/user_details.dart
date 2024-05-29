class UserDetails{
  late int id;
  late String name;
  late String email;
  // late String password;
  late String phoneNumber;
  // late String picture;
  late int age;
  late String jobTitle;
  // late String role;
  // late String buildingNumber;
  // late String imgUrl;

  UserDetails(this.id, this.name, this.email, this.phoneNumber, this.age, this.jobTitle,);

  Map<String, dynamic> toJson()=>{
    'id': id,
    'name': name,
    'email': email,
    // 'password': password,
    'phoneNumber': phoneNumber,
    // 'picture': picture,
    'age': age,
    'job_title': jobTitle,
    // 'role': role,
  };

  UserDetails.fromJson(Map<String, dynamic> json){
    id= json['id'];
    name= json['name'];
    email= json['email'];
    // password= json['password'];
    phoneNumber= json['phone_number'];
    // picture= json['picture'];
    age= json['age'];
    jobTitle= json['job_title'];
    // role= json['role'];
  }
}