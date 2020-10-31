import "package:firebase_auth/firebase_auth.dart";
import "package:google_sign_in/google_sign_in.dart";
import "package:cloud_firestore/cloud_firestore.dart";

bool _isFaculty = true;

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;

Future<User> signIn() async {
  GoogleSignInAccount _signInAcc = await _googleSignIn.signIn();
  GoogleSignInAuthentication _gsa = await _signInAcc.authentication;

  AuthCredential _credential = GoogleAuthProvider.credential(
    accessToken: _gsa.accessToken,
    idToken: _gsa.idToken,
  );

  UserCredential userCred = await _auth.signInWithCredential(_credential);
  User user = userCred.user;

  if (user.email.startsWith(RegExp(r'[0-9]'))) {
    _isFaculty = false;
  } else {
    _isFaculty = true;
  }
  // print(_isFaculty);
  await FirebaseFirestore.instance
      .collection(_isFaculty ? 'facultyusers' : 'studentusers')
      .doc(user.uid)
      .set({
    'email': user.email,
    'imageUrl': user.photoURL,
    'name': user.displayName,
  });
  // print('${user.displayName}');
  return user;
}

void signOut() async {
  await _auth.signOut();
  await _googleSignIn.signOut();
  print("User Logged Out");
}
