import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      // El usuario ya tenía una cuenta en Firebase y ha iniciado sesión correctamente
      return userCredential;
    } catch (e) {
      // Si ocurre un error, puede ser porque el usuario no tiene una cuenta en Firebase
      print(e);

      if (e == 'account-exists-with-different-credential') {
        // El usuario ya tiene una cuenta en Firebase con otro proveedor de autenticación

        // Obtén la lista de proveedores vinculados a la cuenta de Google
        // final List<String> providers =
        //     await auth.fetchSignInMethodsForEmail(googleSignInAccount.email);

        // providers[0] contiene el primer proveedor vinculado a la cuenta de Google
        // final String? firstProvider =
        //     providers.isNotEmpty ? providers[0] : null;

        throw Exception(
            'La cuenta de Google ya está asociada a otra cuenta en Firebase a través de ');
      } else {
        // Otro error ocurrió durante el inicio de sesión con Google
        throw Exception('Error al iniciar sesión con Google: $e');
      }
    }
  }
}
