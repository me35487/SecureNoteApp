import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'home_page.dart';

void main() {
  runApp(NoteApp());
}
// trigger again
class NoteApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '安全记事本',
      home: FingerprintLockScreen(),
    );
  }
}
// rebuild v2
class FingerprintLockScreen extends StatefulWidget {
  @override
  _FingerprintLockScreenState createState() => _FingerprintLockScreenState();
}

class _FingerprintLockScreenState extends State<FingerprintLockScreen> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: '请验证您的指纹以访问记事本',
        options: const AuthenticationOptions(biometricOnly: true),
      );
    } catch (e) {
      print(e);
    }
    if (authenticated) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomePage()));
    }
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('请验证指纹')),
    );
  }
}
// just trigger rebuild
