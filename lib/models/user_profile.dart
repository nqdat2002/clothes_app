class UserProfile {
  String displayName;
  String email;
  String phoneNumber;
  String photoURL;
  bool emailVerified;

  UserProfile({
    required this.displayName,
    required this.email,
    required this.phoneNumber,
    required this.photoURL,
    required this.emailVerified,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      email: json["email"],
      displayName: json["displayName"],
      phoneNumber: json["phoneNumber"],
      photoURL: json["photoURL"],
      emailVerified: json["emailVerified"]
    );
  }

  static List<UserProfile> parseList(dynamic jsonList){
    if (jsonList == null || jsonList is! List || jsonList.isEmpty){
      return [];
    }
    return jsonList.map((json) => UserProfile.fromJson(json)).toList();
  }
}
