class UserList {
  String id;
  String name;
  String email;

  UserList({required this.id, required this.name, required this.email});

  // Pastikan konstruktor fromJson menerima Map<String, dynamic>
  factory UserList.fromJson(Map<String, dynamic> json, String id) {
    return UserList(
      id: id, // Gunakan doc.id sebagai id
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
    };
  }
}
