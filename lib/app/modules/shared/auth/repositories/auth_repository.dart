import 'package:annaluxstore/app/modules/shared/auth/repositories/auth_interface.dart';
import 'package:annaluxstore/app/modules/shared/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository extends Disposable implements IAuthRepository {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {}

  @override
  Future<UserModel> getGoogleLogin() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;

    final userModel = UserModel.fromJson(user);

    return userModel;
  }

  @override
  Future<UserModel> getUser() async {
    final user = await _auth.currentUser();
    var userModel;
    if (user != null) {
      userModel = UserModel.fromJson(user);
    }
    return userModel;
  }

  @override
  Future<void> logout() async {
    _googleSignIn.signOut();
    await _auth.signOut();
  }
}
