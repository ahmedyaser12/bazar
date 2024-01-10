import 'package:firebase_auth/firebase_auth.dart';

FirebaseAuth firebaseAuth = FirebaseAuth.instance;

class FirebaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<UserCredential> signUp(String email, String password) async {
    return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<UserCredential> signIn(String email, String password) async {
    return await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }
}
//import 'package:google_sign_in/google_sign_in.dart';
//
// class GoogleAuthHelper {
//   /// Handle Google Signin to authenticate user
//   Future<GoogleSignInAccount?> googleSignInProcess() async {
//     GoogleSignIn googleSignIn = GoogleSignIn();
//     GoogleSignInAccount? googleUser = await googleSignIn.signIn();
//     if (googleUser != null) {
//       return googleUser;
//     }
//     return null;
//   }
//
//   /// To Check if the user is already signedin through google
//   alreadySignIn() async {
//     GoogleSignIn googleSignIn = GoogleSignIn();
//     bool alreadySignIn = await googleSignIn.isSignedIn();
//     return alreadySignIn;
//   }
//
//   /// To signout from the application if the user is signed in through google
//   Future<GoogleSignInAccount?> googleSignOutProcess() async {
//     GoogleSignIn googleSignIn = GoogleSignIn();
//     GoogleSignInAccount? googleUser = await googleSignIn.signOut();
//
//     return googleUser;
//   }
// }
