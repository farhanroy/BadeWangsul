import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationService extends GetxService {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async {
    // simulated delay
    return _firebaseAuth.currentUser;
  }

  Future<User> createUserWithEmailAndPassword(String userName, String email, String password) async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return userCredential.user;
  }

  Future<User> signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential;
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw AuthenticationException(message: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw AuthenticationException(message: 'Wrong password provided for that user.');
      }
    }

    return userCredential.user;
  }

  Future<void> signOut() {
    return _firebaseAuth.signOut();
  }
}

class AuthenticationException implements Exception {
  final String message;

  AuthenticationException({this.message = 'Unknown error occurred. '});
}