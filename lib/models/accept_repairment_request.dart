class AcceptRepairmentRequest{
  String status;

  AcceptRepairmentRequest(
      this.status,
      );

  Map<String, dynamic> toJson()=>{
    "status": status,
  };
}