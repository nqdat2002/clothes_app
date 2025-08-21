
class Token{
  final String accessToken;
  final String refreshToken;
  final String uid;

  Token({
    required this.accessToken,
    required this.refreshToken,
    required this.uid
  });

  factory Token.fromJson(Map<String, dynamic> json) {
    return Token(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      uid: json["localId"]
    );
  }

  static List<Token> parseList(dynamic jsonList){
    if (jsonList == null || jsonList is! List || jsonList.isEmpty){
      return [];
    }
    return jsonList.map((json) => Token.fromJson(json)).toList();
  }
}