import 'dart:io';

class ProtestRequest{
  String? title;
  String? description;
  String? compliant;
  String? type;
  int? propertyId;
  String? file;

  ProtestRequest(
      this.title,
      this.description,
      this.compliant,
      this.type,
      this.propertyId,
      this.file,
      );

  Map<String, dynamic> toJson()=>{
    'title': title,
    'description': description,
    'compliant': compliant,
    'type': type,
    'property_id': propertyId,
    "picture": file,
  };

  ProtestRequest.fromJson(Map<String, dynamic> json){
    title= json['title'];
    description= json['description'];
    compliant= json['compliant'];
    type= json['type'];
    propertyId= json['property_id'];
    file= json["picture"];
  }
}