class Author {
  String id;
  String username;
  String photo;

  Author.blank()
      : id = "",
        username = "",
        photo = "";

  Author.fromJson(Map json) {
    id = json["id"];
    username = json["username"];
    photo = json["photo"];
  }

  static Object authorToJson(Author author) {
    return {
      "id": author.id,
      "username": author.username,
      "photo": author.photo
    };
  }
}
