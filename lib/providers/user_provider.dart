import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class UserNotifier extends StateNotifier<UserProfile?> {
  UserNotifier() : super(null);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Load user from FirebaseAuth on app start
  Future<void> fetchUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      state = UserProfile(
        uid: user.uid,
        name: user.displayName ?? 'User',
        email: user.email ?? '',
        profilePictureUrl: user.photoURL,
        createdAt: user.metadata.creationTime ?? DateTime.now(),
      );
    }
  }

  /// Log out from Google + Firebase, clear provider
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      state = null;
    } catch (e) {
      print("Logout Error: $e");
    }
  }

  /// Optional helper to clear state if needed
  void clearUser() {
    state = null;
  }

  /// Set user after fresh login
  void setUser(User user) {
    state = UserProfile(
      uid: user.uid,
      name: user.displayName ?? 'User',
      email: user.email ?? '',
      profilePictureUrl: user.photoURL,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
    );
  }

  /// Refresh profile picture
  Future<void> updateProfilePicture() async {
    await _auth.currentUser?.reload();
    await fetchUserData();
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserProfile?>((ref) {
  return UserNotifier();
});
