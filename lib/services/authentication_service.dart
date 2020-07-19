import 'dart:async';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../model/base_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookLogin facebookLogin = FacebookLogin();
  String errorMessage;

  Future<String> signIn(String email, String password) async {
    AuthResult result;
    FirebaseUser user;
    try {
      result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user;
      if (user.isEmailVerified) return user.uid;
    } catch (error) {
      switch (error.code) {
        case "ERROR_INVALID_EMAIL":
          errorMessage = "Your email address appears to be malformed.";
          break;
        case "ERROR_WRONG_PASSWORD":
          errorMessage = "Your password is wrong.";
          break;
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "ERROR_USER_DISABLED":
          errorMessage = "User with this email has been disabled.";
          break;
        case "ERROR_TOO_MANY_REQUESTS":
          errorMessage = "Too many requests. Try again later.";
          break;
        case "ERROR_OPERATION_NOT_ALLOWED":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }

      return Future.error(errorMessage);
    }
  }

  Future<String> signUp(String email, String password) async {
    try {
      AuthResult result = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return user.uid;
    } catch (e) {
      return null;
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user;
  }

  Future<void> signOut() async {
    print(getCurrentUser());

    if (await _googleSignIn.isSignedIn()) _googleSignIn.signOut();
    return _firebaseAuth.signOut();
  }

  Future<FirebaseUser> signInViaGoogle() async {
    FirebaseUser user;

    try {
      bool isSignedIn = await _googleSignIn.isSignedIn();

      if (isSignedIn) {
        user = await _firebaseAuth.currentUser();
      } else {
        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        user = (await _firebaseAuth.signInWithCredential(credential)).user;
      }
      return user;
    } catch (error) {
      switch (error.code) {
        case "SIGN_IN_CANCELLED":
          errorMessage = null;
          break;

        case "SIGN_IN_CURRENTLY_IN_PROGRESS":
          errorMessage = "A sign in process is currently in progress";
          break;

        case "SIGN_IN_FAILED":
          errorMessage =
              "The sign in attempt didn't succeed with the current account.";
          break;

        default:
          errorMessage = "An undefined Error happened.";
      }
      return Future.error(errorMessage);
    }
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  Future<FirebaseUser> signInViaFacebook() async {
    final result = await facebookLogin
        .logInWithReadPermissions(['email']); //.then((result) {
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        String token = result.accessToken.token;
        AuthCredential credential =
            FacebookAuthProvider.getCredential(accessToken: token);
        print('ok');
        return (await _firebaseAuth.signInWithCredential(credential)).user;
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }
    return null;
  }
}
