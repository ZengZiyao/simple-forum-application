import 'package:simple_forum_app/models/author.dart';
import 'package:simple_forum_app/models/item.dart';

class Answer implements Item{
  String aId;
  String description;
  int createdTime;
  int updatedTime;
  int commentCount;
  int voteupCount;
  Author author;
  String content;

    Answer.blank()
      : aId = "",
        content = "",
        author = Author.blank();

 Answer.fromJson(Map<String, dynamic> json) {
   
      aId = json["aId"];
      description = json["description"];
      createdTime = json["createdTime"];
      updatedTime = json["updtedTime"];
      commentCount = json["commentCount"];
      voteupCount = json["voteupCount"];
      content = json["content"];


      if (json["author"] != null) {
        author = Author.fromJson(json["author"]);
      }

  }
}