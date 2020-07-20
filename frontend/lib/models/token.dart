class Token {
  String accessToken;
  String tokenType;

    Token({this.accessToken, this.tokenType});

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json['access_token'],
      tokenType: json['token_type'],
    );
  }
}