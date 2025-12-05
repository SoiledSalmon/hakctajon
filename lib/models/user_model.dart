class UserProfile {
  final String uid;
  final String name;
  final String email;
  final String? profilePictureUrl;
  final DateTime createdAt;

  UserProfile({
    required this.uid,
    required this.name,
    required this.email,
    this.profilePictureUrl,
    required this.createdAt,
  });

  // Factory constructor to create a UserProfile from a Firebase User object
  factory UserProfile.fromMap(Map<String, dynamic> data) {
    return UserProfile(
      uid: data['uid'] ?? '',
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      profilePictureUrl: data['profilePictureUrl'],
      createdAt: DateTime.parse(data['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'profilePictureUrl': profilePictureUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
