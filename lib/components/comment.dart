import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentBox extends StatefulWidget {
  final String? turfId;

  const CommentBox({super.key, required this.turfId});

  @override
  State<CommentBox> createState() => _CommentBoxState();
}

class _CommentBoxState extends State<CommentBox> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _controller,
          decoration: const InputDecoration(
            hintText: 'Enter your comment',
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            if (widget.turfId != null && _controller.text.isNotEmpty) {
              postComment(widget.turfId!, _controller.text);
            }
          },
          child: const Text('Post'),
        ),
        const SizedBox(height: 16),
        FutureBuilder<List<Comment>>(
          future: fetchComments(widget.turfId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting){
              return const CircularProgressIndicator();
            }else if (snapshot.hasError){
              return Text('Error: ${snapshot.error}');
            }else if (snapshot.hasData && snapshot.data != null){
              final comments = snapshot.data!;
              return Column(
                children: comments.map((comment)=> CommentWidget(comment: comment)).toList(),
              );
            }else{
              return const Text('No comments available');
            }
          },)
],
    );
  }

  Future<List<Comment>> fetchComments(String? turfId) async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/reviews?turf_id=$turfId'));
    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final List<dynamic> jsonComments = jsonBody['data'];
      return jsonComments.map((jsonComment) => Comment.fromJson(jsonComment)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }

  void postComment(String turfId, String commentContent) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:8000/api/reviews'),
        body: {
          'turf_id': turfId,
          'comments': commentContent,
        },
      );

      if (response.statusCode == 200) {
        // Handle successful response
        // You can update the UI or show a success message
      } else {
        // Handle error response
        // You can show an error message to the user
      }
    } catch (e) {
      // Handle exceptions
      // You can show an error message or handle the error accordingly
    }
  }
}

class Comment {
  final String id;
  final String userId;
  final String turfId;
  final String content;
  final DateTime createdAt;

  Comment({
    required this.id,
    required this.userId,
    required this.turfId,
    required this.content,
    required this.createdAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'].toString(),
      userId: json['user_id'].toString(),
      turfId: json['turf_id'].toString(),
      content: json['comments'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}

class CommentWidget extends StatelessWidget {
  final Comment comment;

  const CommentWidget({Key? key, required this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(comment.content),
        const SizedBox(height: 8),
        Text('Posted by ${comment.userId} at ${comment.createdAt}'),
      ],
    );
  }
}
