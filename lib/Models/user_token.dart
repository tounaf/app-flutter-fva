class UserToken {
  final String token;

  const UserToken({
        required this.token
      });

  factory UserToken.fromJson(Map<String, dynamic> json) {
    return UserToken(
      token: json['token'],
    );
  }
}