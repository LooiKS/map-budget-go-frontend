import 'dart:async';
import 'package:budgetgo/model/user.dart';
import 'package:budgetgo/services/users_date_service.dart';
import 'package:budgetgo/utils/preference.dart';
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
    FirebaseUser fuser;
    try {
      result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      fuser = result.user;

      User user = await userDataService.getUser(id: fuser.uid);
      Utils.fuser = fuser;
      Utils.user = user;
      return fuser.uid;
      // if (user.isEmailVerified) return user.uid;
      // return null;
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
      user.sendEmailVerification();
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
    if (await _googleSignIn.isSignedIn()) _googleSignIn.signOut();
    return _firebaseAuth.signOut();
  }

  Future<FirebaseUser> signInViaGoogle() async {
    FirebaseUser fuser;

    try {
      bool isSignedIn = await _googleSignIn.isSignedIn();

      if (isSignedIn) {
        fuser = await _firebaseAuth.currentUser();
      } else {
        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.getCredential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);

        fuser = (await _firebaseAuth.signInWithCredential(credential)).user;
      }
      User user = await userDataService.getUser(id: fuser.uid);
      Utils.fuser = fuser;
      Utils.user = user;
      return fuser;
    } catch (error) {
      switch (error.code) {
        case "ERROR_SIGN_IN_CANCELLED":
          errorMessage = null;
          break;

        case "ERROR_SIGN_IN_CURRENTLY_IN_PROGRESS":
          errorMessage = "A sign in process is currently in progress";
          break;

        case "ERROR_SIGN_IN_FAILED":
          errorMessage =
              "The sign in attempt didn't succeed with the current account.";
          break;

        default:
          errorMessage = "An undefined Error happened. Please try again later.";
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

  Future<String> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error) {
      switch (error.code) {
        case "ERROR_USER_NOT_FOUND":
          errorMessage = "There is no user corresponding to the email address.";
          break;

        case "ERROR_INVALID_EMAIL":
          errorMessage = "The email address is not valid";
          break;

        default:
          errorMessage = "An error happened. Please try again later!";
      }
      return Future.error(errorMessage);
    }
    return null;
  }

  Future<void> changePassword(String oldPassword, String newPassword) async {
    FirebaseUser user = await _firebaseAuth.currentUser();

    try {
      await user.reauthenticateWithCredential(EmailAuthProvider.getCredential(
          email: user.email, password: oldPassword));
      await user.updatePassword(newPassword);
    } catch (error) {
      switch (error.code) {
        case "ERROR_WEAK_PASSWORD":
          errorMessage =
              "The given password is invalid. Password should be at least 6 characters.";
          break;

        case "ERROR_WRONG_PASSWORD":
          errorMessage = "The old password is not match.";
          break;

        default:
          errorMessage = "An error happened. Please try again later!";
      }

      return Future.error(errorMessage);
    }
    return null;
  }

  Future<FirebaseUser> signInViaFacebook() async {
    final result = await facebookLogin
        .logInWithReadPermissions(['email']); //.then((result) {
    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        String token = result.accessToken.token;
        AuthCredential credential =
            FacebookAuthProvider.getCredential(accessToken: token);
        FirebaseUser fuser =
            (await _firebaseAuth.signInWithCredential(credential)).user;
        User user = await userDataService.getUser(id: fuser.uid);
        Utils.fuser = fuser;
        Utils.user = user;
        return fuser;
        break;
      case FacebookLoginStatus.cancelledByUser:
        break;
      case FacebookLoginStatus.error:
        break;
    }
    return null;
  }
}
