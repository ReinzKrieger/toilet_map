class UserList {
  String id;
  String name;
  String email;
  String username;
  String bio;

  UserList(
      {required this.id,
      required this.name,
      this.email = '',
      this.username = '',
      this.bio = ''});

  // Pastikan konstruktor fromJson menerima Map<String, dynamic>
  factory UserList.fromJson(Map<String, dynamic> json, String id) {
    return UserList(
      id: id, // Gunakan doc.id sebagai id
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      bio: json['bio'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'username': username,
      'bio': bio,
    };
  }
}
