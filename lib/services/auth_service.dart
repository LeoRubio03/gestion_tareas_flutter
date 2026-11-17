
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Registrar un usuario
  Future<UserCredential> registrarUsuario(
    String correo,
    String contrasena,
  ) async {
    return await _auth.createUserWithEmailAndPassword(
      email: correo,
      password: contrasena,
    );
  }

  // Iniciar sesión
  Future<UserCredential> iniciarSesion(
    String correo,
    String contrasena,
  ) async {
    return await _auth.signInWithEmailAndPassword(
      email: correo,
      password: contrasena,
    );
  }

  // Cerrar sesión
  Future<void> cerrarSesion() async {
    await _auth.signOut();
  }

  // Obtener usuario actual
  User? obtenerUsuarioActual() {
    return _auth.currentUser;
  }

  // Escuchar cambios de sesión
  Stream<User?> get estadoAutenticacion {
    return _auth.authStateChanges();
  }
}
