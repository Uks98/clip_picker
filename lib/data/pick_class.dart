class Pick {
  int id;
  String name;
  String memo;
  int time;
  int date;
  int studyTime;
  int studyType;
  int hardStudy;
  String image;
  int color;
  Pick({this.id,this.name, this.memo, this.time, this.date,this.studyTime, this.studyType,
    this.hardStudy, this.image,this.color,});

  factory Pick.fromDB(Map<String,dynamic> data){
    return Pick(
      id: data["id"],
      name: data["name"].toString(),
      memo: data["memo"].toString(),
      time: data["time"],
      date: data["date"],
      studyTime: data["studyTime"],
      studyType: data["studyType"],
      hardStudy: data["hardStudy"],
      image: data["image"],
      color: data["color"],
    );
  }
  Map<String,dynamic> toMap(){
    return {
      "id":this.id,
      "name":this.name,
      "memo":this.memo,
      "time":this.time,
      "date":this.date,
      "studyType":this.studyType,
      "studyTime":this.studyTime,
      "hardStudy":this.hardStudy,
      "image":this.image,
      "color":this.color,
    };
  }
}
