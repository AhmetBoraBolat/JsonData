import 'package:flutter/material.dart';
import 'package:json_convert_data/service/models/post_model.dart';
import 'package:json_convert_data/service/post_service.dart';

class JsonPostMethod extends StatefulWidget {
  const JsonPostMethod({Key? key}) : super(key: key);

  @override
  State<JsonPostMethod> createState() => _JsonPostMethodState();
}

class _JsonPostMethodState extends State<JsonPostMethod> {
  String? name;

  final model = PostModel();
  late final IPostService _postService; // testable code

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _userIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _postService = PostService();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _bodyController,
              decoration: const InputDecoration(labelText: 'Body'),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.next,
            ),
            TextField(
              controller: _userIdController,
              decoration: const InputDecoration(labelText: 'UserId'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(
              height: 40,
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
              ),
              onPressed: () async {
                if (_titleController.text.isNotEmpty &&
                    _bodyController.text.isNotEmpty &&
                    _userIdController.text.isNotEmpty) {
                  model.body = _bodyController.text;
                  model.title = _titleController.text;
                  model.userId = int.tryParse(_userIdController.text);

                  bool success = await _postService.addItemToService(model);
                  setState(() {
                    name = success ? 'başarılı' : 'hata';
                  });
                }
              },
              child: const Text(
                'Send',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              name ?? '',
              style: TextStyle(
                color: name == 'başarılı' ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
