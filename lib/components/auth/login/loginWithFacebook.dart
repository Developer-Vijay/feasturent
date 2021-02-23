// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_login/flutter_facebook_login.dart';

// final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

// Future<String> loginWithFacebook() async {
//   FacebookLoginResult facebookLoginResult = await _handleFBSignIn();
//   final accessToken = facebookLoginResult.accessToken.token;
//   if (facebookLoginResult.status == FacebookLoginStatus.loggedIn) {
//     final facebookAuthCred =
//         FacebookAuthProvider.getCredential(accessToken: accessToken);
//     final user = await firebaseAuth.signInWithCredential(facebookAuthCred);
//     print("User : ");
//     print(user.additionalUserInfo.username);
//   } else {
//     print('LOGIN Faild!');
//   }
// }

// Future<FacebookLoginResult> _handleFBSignIn() async {
//   FacebookLogin facebookLogin = FacebookLogin();
//   FacebookLoginResult facebookLoginResult =
//       await facebookLogin.logIn(['email']);
//   switch (facebookLoginResult.status) {
//     case FacebookLoginStatus.cancelledByUser:
//       print("Cancelled");
//       break;
//     case FacebookLoginStatus.error:
//       print("error");
//       break;
//     case FacebookLoginStatus.loggedIn:
//       print("Logged In");
//       break;
//   }
//   return facebookLoginResult;
// }
