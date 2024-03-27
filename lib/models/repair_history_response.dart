class RepairHistoryResponse{
  List<EachRepairResponse>? historyOfRepairs;

  RepairHistoryResponse(
      this.historyOfRepairs,
      );

  factory RepairHistoryResponse.fromJson(List<dynamic> json){
    List<EachRepairResponse> eachRepairResponse=[];
    eachRepairResponse= json.map((book) => EachRepairResponse.fromJson(book)).toList().reversed.toList();
    return RepairHistoryResponse(eachRepairResponse);
  }

}

class EachRepairResponse{
  int? id;
  String? title;
  String? repairmentComponents;
  String? description;
  String? picture;
  String? status;
  String? requestDate;
  String? expirationDate;
  int? completedUser;
  String? createdAt;
  String? updatedAt;
  int? requestedBy;
  String? acceptedBy;
  String? location;

  EachRepairResponse(
      this.id,
      this.title,
      this.repairmentComponents,
      this.description,
      this.picture,
      this.status,
      this.requestDate,
      this.expirationDate,
      this.completedUser,
      this.createdAt,
      this.updatedAt,
      this.requestedBy,
      this.acceptedBy,
      this.location,
      );

  factory EachRepairResponse.fromJson(Map<String, dynamic> json){
    return EachRepairResponse(
        json["id"],
        json["title"],
        json["repairment_components"],
    json["description"],
    json["picture"],
    json["status"],
    json["request_date"],
    json["expiration_date"],
    json["completed_user"],
    json["created_at"],
    json["updated_at"],
        json["requested_by"],
        json["accepted_by"],
    json["location"],
    );
  }

}