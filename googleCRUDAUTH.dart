/*

dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.20.0
  firebase_auth: ^4.12.0
  provider: ^6.1.0

*/

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus { uninitialized, authenticated, unauthenticated, loading }

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;
  User? get user => _user;

  AuthStatus _status = AuthStatus.uninitialized;
  AuthStatus get status => _status;

  AuthProvider() {
    _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  Future<void> signUp(String email, String password) async {
    _setStatus(AuthStatus.loading);
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user = result.user;
      _setStatus(AuthStatus.authenticated);
    } on FirebaseAuthException catch (e) {
      _setStatus(AuthStatus.unauthenticated);
      throw _handleFirebaseError(e);
    }
  }

  Future<void> login(String email, String password) async {
    _setStatus(AuthStatus.loading);
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _user = result.user;
      _setStatus(AuthStatus.authenticated);
    } on FirebaseAuthException catch (e) {
      _setStatus(AuthStatus.unauthenticated);
      throw _handleFirebaseError(e);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    _setStatus(AuthStatus.unauthenticated);
  }

  void _onAuthStateChanged(User? user) {
    _user = user;
    _setStatus(user == null ? AuthStatus.unauthenticated : AuthStatus.authenticated);
  }

  void _setStatus(AuthStatus status) {
    _status = status;
    notifyListeners();
  }

  String _handleFirebaseError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'Email is already in use.';
      case 'invalid-email':
        return 'Email is invalid.';
      case 'user-not-found':
        return 'User not found.';
      case 'wrong-password':
        return 'Incorrect password.';
      default:
        return 'Authentication error: ${e.message}';
    }
  }
}
class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    switch (auth.status) {
      case AuthStatus.uninitialized:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case AuthStatus.authenticated:
        return const HomeScreen();
      case AuthStatus.unauthenticated:
        return const LoginScreen();
      case AuthStatus.loading:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
  }
}
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String? errorMessage;

  void handleLogin() async {
    final auth = Provider.of<AuthProvider>(context, listen: false);
    try {
      await auth.login(emailController.text, passwordController.text);
    } catch (e) {
      setState(() => errorMessage = e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            if (errorMessage != null) Text(errorMessage!, style: TextStyle(color: Colors.red)),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: passwordController, obscureText: true, decoration: const InputDecoration(labelText: 'Password')),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: handleLogin, child: const Text("Login")),
            TextButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupScreen())),
              child: const Text("No account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
ElevatedButton(
  onPressed: () => Provider.of<AuthProvider>(context, listen: false).logout(),
  child: const Text("Logout"),
)
