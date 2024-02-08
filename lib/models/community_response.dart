class CommunityResponse{
  late String date;
  late String img;
  late String title;
  late String content;

  CommunityResponse(
    this.date,
    this.img,
    this.title,
    this.content,
  );

  Map<String, dynamic> toJson()=>{
    'date': date,
    'img': img,
    'title': title,
    'content': content,
  };

  CommunityResponse.fromJson(Map<String, dynamic> json){
    date= json['date'];
    img= json['img'];
    title= json['title'];
    content= json['content'];
  }
}