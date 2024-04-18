class AcceptRepairmentRequest{
  int? id;
  String status;

  AcceptRepairmentRequest(
      this.id,
      this.status,
      );

  Map<String, dynamic> toJson()=>{
    "id": id,
    "status": status,
  };
}