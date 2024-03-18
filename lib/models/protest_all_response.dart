class EachProtestResponse{
  int? id;
  String? title;
  String? description;
  String? compliant;
  String? picture;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? madeBy;
  String? location;

  EachProtestResponse(
      this.id,
      this.title,
      this.description,
      this.compliant,
      this.picture,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.madeBy,
      this.location,
      );

  factory EachProtestResponse.fromJson(Map<String, dynamic> json) {
    return EachProtestResponse(
        json['id'],
        json['title'],
        json['description'],
        json['compliant'],
        json['picture'],
        json['status'],
        json['created_at'],
        json['updated_at'],
        json['made_by'],
        json['location']);
  }
  // EachProtestResponse.fromJson(Map<String, dynamic> json){
  //   id= json['id'];
  //   title= json['title'];
  //   description= json['description'];
  //   compliant= json['compliant'];
  //   picture= json['picture'];
  //   status= json['status'];
  //   createdAt= json['created_at'];
  //   updatedAt= json['updated_at'];
  //   madeBy= json['made_by'];
  //   location= json['location'];
  // }
}

class ProtestAllResponse{
  List<EachProtestResponse>? eachProtestResponse;

  ProtestAllResponse(
      this.eachProtestResponse,
      );

  factory ProtestAllResponse.fromJson(List<dynamic> json) {
    List<EachProtestResponse> books = [];
    books = json.map((book) => EachProtestResponse.fromJson(book)).toList().reversed.toList();
    return ProtestAllResponse(books);
  }
}