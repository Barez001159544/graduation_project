class ProtestRequest{
  late String title;
  late String complaint;
  late String picture;
  late String date;
  late String place;
  late String status;
  late String topic;
  late String userId;
  late String createdAt;
  late String updatedAt;

  ProtestRequest(
      this.title,
      this.complaint,
      this.picture,
      this.date,
      this.place,
      this.status,
      this.topic,
      this.userId,
      this.createdAt,
      this.updatedAt,
      );

  Map<String, dynamic> toJson()=>{
    'title': title,
    'complaint': complaint,
    'picture': picture,
    'date': date,
    'place': place,
    'status': status,
    'topic': topic,
    'userId': userId,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };

  ProtestRequest.fromJson(Map<String, dynamic> json){
    title= json['title'];
    complaint= json['complaint'];
    picture= json['picture'];
    date= json['date'];
    place= json['place'];
    status= json['status'];
    topic= json['topic'];
    userId= json['userId'];
    createdAt= json['createdAt'];
    updatedAt= json['updatedAt'];
  }
}