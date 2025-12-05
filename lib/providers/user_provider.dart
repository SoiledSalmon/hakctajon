import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/user_model.dart';

class UserNotifier extends StateNotifier<UserProfile?> {
  UserNotifier() : super(null);

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  /// Populates state from Firebase Auth on app start
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

  /// Clears user state and signs out from Firebase and Google
  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
      state = null;
    } catch (e) {
      // Handle error implicitly or log it
      print('Error signing out: $e');
    }
  }

  /// Updates profile picture from Google account (syncs current auth state)
  Future<void> updateProfilePicture() async {
    await _auth.currentUser?.reload();
    await fetchUserData();
  }

  /// Helper to set user directly (e.g. after fresh login)
  void setUser(User user) {
    state = UserProfile(
      uid: user.uid,
      name: user.displayName ?? 'User',
      email: user.email ?? '',
      profilePictureUrl: user.photoURL,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
    );
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserProfile?>((ref) {
  return UserNotifier();
});
