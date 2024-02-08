class ProtestRequest{
  late String date;
  late String title;
  late String coreMessage;

  ProtestRequest(
      this.date,
      this.title,
      this.coreMessage,
      );

  Map<String, dynamic> toJson()=>{
    'date': date,
    'title': title,
    'coreMessage': coreMessage,
  };

  ProtestRequest.fromJson(Map<String, dynamic> json){
    date= json['date'];
    title= json['title'];
    coreMessage= json['coreMessage'];
  }
}