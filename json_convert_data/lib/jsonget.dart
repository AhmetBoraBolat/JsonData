import 'package:flutter/material.dart';
import 'package:json_convert_data/service/models/post_model.dart';
import 'package:json_convert_data/service/post_service.dart';

class JsonGetMethod extends StatefulWidget {
  const JsonGetMethod({super.key});

  @override
  State<JsonGetMethod> createState() => _JsonGetMethod();
}

class _JsonGetMethod extends State<JsonGetMethod> {
  List<PostModel>? _items;
  bool _isLoading = false;

  late final IPostService _postService; // testable code

  @override
  void initState() {
    super.initState();
    _postService = PostService();
    fetchPostItemsAdvance();
  }

  void _changeLoading() {
    setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<void> fetchPostItemsAdvance() async {
    _changeLoading();
    _items = await _postService.fetchPostItems();
    _changeLoading();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        actions: [
          _isLoading
              ? const CircularProgressIndicator.adaptive()
              : const SizedBox.shrink()
        ],
      ),
      body: _items == null
          ? const Placeholder()
          : ListView.builder(
              padding: const EdgeInsetsDirectional.symmetric(horizontal: 10),
              itemCount: _items?.length ?? 0,
              itemBuilder: (context, index) {
                return _PostCard(postModel: _items?[index]);
              },
            ),
    );
  }
}

class _PostCard extends StatelessWidget {
  const _PostCard({
    Key? key,
    required PostModel? postModel,
  })  : _postModel = postModel,
        super(key: key);

  final PostModel? _postModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsetsDirectional.only(bottom: 20),
      child: ListTile(
        title: Text(_postModel?.title ?? ''),
        subtitle: Text(_postModel?.body ?? ''),
      ),
    );
  }
}
