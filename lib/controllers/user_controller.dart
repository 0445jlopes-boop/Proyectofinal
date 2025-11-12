import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserController {

  static String? nombre ="";
  static String? email ="";
  static String? foto ="";
  
  static Future<UserCredential?> loginGoogle() async{
    try{
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if(googleUser == null){
        return null;
      }
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, 
        idToken: googleAuth.idToken 
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      nombre = googleUser.displayName;
      email = googleUser.email;
      foto = googleUser.photoUrl;
      
    }catch(e){
      return null;
    }
  }

  static Future<bool> logoutGoogle() async {
    try{
      final GoogleSignIn googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
      return true;
    }catch(e){
      print('Error: $e');
      return false;
    }
  }
}


