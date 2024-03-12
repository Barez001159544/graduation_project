class UpdateUserRequest{
  String? phoneNumber;
  String? jobTitle;
  String? password;

  UpdateUserRequest(this.phoneNumber, this.jobTitle, this.password);

  Map<String, dynamic> toJson()=>{
    'phone_number': phoneNumber,
    'job_title': jobTitle,
    'password': password,
  };
}