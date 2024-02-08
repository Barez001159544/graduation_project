class RepairRequest{
  late int id;
  late String client;
  late List<Map<String, bool>> items;

  RepairRequest(
      this.id,
      this.client,
      this.items,
      );

  Map<String, dynamic> toJson()=>{
    'id': id,
    'client': client,
    'items': items,
  };

  RepairRequest.fromJson(Map<String, dynamic> json){
    id= json['id'];
    client= json['client'];
    items= json['items'];
  }
}