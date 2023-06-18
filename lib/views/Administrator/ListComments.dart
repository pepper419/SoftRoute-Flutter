import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ListComments extends StatefulWidget {
  @override
  _ListCommentsState createState() => _ListCommentsState();
}

class _ListCommentsState extends State<ListComments> {
  late Future<List<Comment>> _comments;

  @override
  void initState() {
    super.initState();
    _comments = fetchComments();
  }

  Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse('http://20.150.216.134:7070/api/v1/feedbacks'));
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<Comment> comments = [];
      for (var item in data) {
        final commentResponse = await http.get(Uri.parse('http://20.150.216.134:7070/api/v1/feedback/${item['id']}'));
        if (commentResponse.statusCode == 200) {
          final commentData = jsonDecode(commentResponse.body);
          final Comment comment = Comment.fromJson(commentData);
          comments.add(comment);
        }
      }
      return comments;
    } else {
      throw Exception('fallo la carga :(');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: FutureBuilder<List<Comment>>(
        future: _comments,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final comments = snapshot.data!;
            return ListView.builder(
              itemCount: comments.length,
              itemBuilder: (context, index) {
                final comment = comments[index];
                return ListTile(
                  title: Text(comment.title),
                  subtitle: Text(comment.body),
                  // Add more details from the comment if needed
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Failed to fetch comments"),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class Comment {
  final String title;
  final String body;

  Comment({
    required this.title,
    required this.body,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      title: json['title'],
      body: json['body'],
    );
  }
}
