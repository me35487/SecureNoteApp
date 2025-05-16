import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(const SecureNoteApp());
}

class SecureNoteApp extends StatelessWidget {
  const SecureNoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Secure Note',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const NoteHomePage(),
    );
  }
}

class NoteHomePage extends StatefulWidget {
  const NoteHomePage({super.key});
  @override
  State<NoteHomePage> createState() => _NoteHomePageState();
}

class _NoteHomePageState extends State<NoteHomePage> {
  final LocalAuthentication auth = LocalAuthentication();
  bool _authenticated = false;
  final TextEditingController _controller = TextEditingController();

  Future<void> _authenticate() async {
    bool authenticated = await auth.authenticate(
      localizedReason: 'Please authenticate to access your notes',
      options: const AuthenticationOptions(biometricOnly: true),
    );
    setState(() {
      _authenticated = authenticated;
    });
  }

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Secure Note')),
      body: _authenticated
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                maxLines: null,
                decoration: const InputDecoration(hintText: 'Write your notes...'),
              ),
            )
          : const Center(child: Text('Authentication failed')),
    );
  }
}
