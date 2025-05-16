import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller = TextEditingController();
  String _savedText = '';

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  _loadNote() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedText = prefs.getString('note') ?? '';
      _controller.text = _savedText;
    });
  }

  _saveNote(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('note', value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('我的记事本')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          controller: _controller,
          maxLines: null,
          onChanged: _saveNote,
          decoration: InputDecoration(
            hintText: '在这里输入你的内容...',
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
